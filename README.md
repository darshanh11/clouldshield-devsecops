# CloudShield – Secure Cloud DevSecOps Platform

A portfolio project demonstrating **cloud infrastructure, Terraform, Docker, CI/CD, Linux, networking, IAM, monitoring, and security scanning**.

> **Primary implementation:** AWS  
> **Cloud portability:** Azure and GCP service mapping is documented so the same architecture can be discussed across all three major cloud platforms.

## Architecture

```text
Developer
   |
   v
GitHub Repository
   |
   v
GitHub Actions
   |---- Unit tests
   |---- Docker build
   |---- Trivy image scan
   |---- Terraform fmt/validate
   |
   v
Amazon ECR
   |
   v
AWS EC2
   |
   +--> Docker container
   |       |
   |       +--> Flask API
   |
   +--> Nginx reverse proxy
   |
   +--> CloudWatch monitoring
   |
   +--> IAM instance role
   |
   +--> Security Group
   |
   +--> VPC / Public Subnet
   |
   +--> S3 Terraform state (recommended)
```

## What this project demonstrates

- Infrastructure as Code with Terraform
- AWS VPC, subnet, route table, internet gateway and security groups
- EC2 Linux administration
- IAM least-privilege concepts
- Docker containerization
- Nginx reverse proxy
- GitHub Actions CI/CD
- Trivy container security scanning
- Health checks and application logging
- CloudWatch monitoring
- Environment variables and secrets hygiene
- Git/GitHub workflow
- AWS/Azure/GCP service mapping

## Project structure

```text
cloudshield-devsecops/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── nginx/
│   └── nginx.conf
├── terraform/
│   ├── versions.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── security.tf
│   ├── outputs.tf
│   └── user-data.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── docs/
│   ├── cloud-mapping.md
│   └── interview-notes.md
├── .gitignore
└── README.md
```

## Local run

```bash
cd app
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

Open:

```text
http://localhost:5000/health
http://localhost:5000/
```

## Docker run

```bash
docker build -t cloudshield-api ./app
docker run -d --name cloudshield-api -p 5000:5000 cloudshield-api
curl http://localhost:5000/health
```

## Terraform deployment

Prerequisites:

- AWS account
- AWS CLI configured
- Terraform installed
- An EC2-compatible AWS region selected

```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

After deployment:

```bash
terraform output
```

The output contains the instance public IP.

> For a real production deployment, use private subnets for application/database tiers, an ALB, HTTPS certificates, SSM instead of direct SSH, a remote encrypted Terraform state backend, and tighter security-group rules.

## Security controls

This project intentionally demonstrates:

1. Only HTTP is exposed by default.
2. SSH is restricted by `admin_cidr` instead of allowing the whole internet.
3. EC2 uses an IAM instance profile rather than storing AWS access keys on the server.
4. Docker images are scanned by Trivy in CI.
5. Secrets are kept out of Git.
6. Terraform validates infrastructure before deployment.

## CI/CD

GitHub Actions performs:

```text
Push / Pull Request
        |
        +--> Python dependency install
        +--> Application smoke test
        +--> Docker build
        +--> Trivy vulnerability scan
        +--> Terraform fmt check
        +--> Terraform validate
```

The workflow is deliberately safe by default: it does **not** automatically create AWS infrastructure from an untrusted pull request.

## AWS → Azure → GCP mapping

| Capability | AWS | Azure | GCP |
|---|---|---|---|
| VM | EC2 | Azure Virtual Machines | Compute Engine |
| Network | VPC | VNet | VPC |
| Object storage | S3 | Blob Storage | Cloud Storage |
| IAM | IAM | Microsoft Entra ID / Azure RBAC | Cloud IAM |
| Container registry | ECR | Azure Container Registry | Artifact Registry |
| Monitoring | CloudWatch | Azure Monitor | Cloud Monitoring |
| Kubernetes | EKS | AKS | GKE |
| Serverless functions | Lambda | Azure Functions | Cloud Functions |

## Interview explanation

**Problem:** A small application needs repeatable infrastructure, containerization, security checks, and automated validation.

**Solution:** Terraform provisions the AWS networking and EC2 foundation. Docker packages the application. GitHub Actions validates code and infrastructure and scans the container image. Nginx provides a reverse-proxy layer and CloudWatch provides monitoring.

**Why Terraform?** The infrastructure becomes version-controlled, repeatable, reviewable, and easier to reproduce.

**Why Docker?** The application and dependencies are packaged consistently across environments.

**Why IAM roles instead of access keys on EC2?** The workload can receive temporary credentials through the instance role, reducing the risk of hard-coded long-lived credentials.

**Why restrict SSH?** Port 22 should not be exposed to everyone. The Terraform variable `admin_cidr` limits administrative access to a trusted CIDR.

## Important portfolio rule

Do not write that you deployed the project to AWS, Azure, or GCP until you have actually done it. After you deploy and test it yourself, add screenshots, Terraform output, GitHub Actions results, and a short "What I learned" section.

## Cleanup

To avoid AWS charges:

```bash
cd terraform
terraform destroy
```
