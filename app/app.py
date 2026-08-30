from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

@app.get("/")
def home():
    return jsonify({
        "service": "CloudShield API",
        "status": "running",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "development")
    })

@app.get("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.get("/ready")
def ready():
    return jsonify({"status": "ready"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
