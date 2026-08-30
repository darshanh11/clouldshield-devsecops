#!/bin/bash
set -eux

dnf update -y
dnf install -y docker nginx

systemctl enable --now docker
systemctl enable --now nginx

mkdir -p /opt/cloudshield
cd /opt/cloudshield

cat > app.py <<'PY'
from flask import Flask, jsonify
import socket
app = Flask(__name__)

@app.get("/")
def home():
    return jsonify({
        "service": "CloudShield API",
        "status": "running",
        "hostname": socket.gethostname()
    })

@app.get("/health")
def health():
    return jsonify({"status": "healthy"}), 200
PY

cat > requirements.txt <<'REQ'
Flask==3.1.1
REQ

cat > Dockerfile <<'DOCKER'
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
EXPOSE 5000
CMD ["python", "app.py"]
DOCKER

docker build -t cloudshield-api:latest .
docker rm -f cloudshield-api 2>/dev/null || true
docker run -d --restart unless-stopped --name cloudshield-api -p 127.0.0.1:5000:5000 cloudshield-api:latest

cat > /etc/nginx/conf.d/cloudshield.conf <<'NGINX'
server {
    listen 80 default_server;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
NGINX

rm -f /etc/nginx/conf.d/default.conf 2>/dev/null || true
nginx -t
systemctl restart nginx
