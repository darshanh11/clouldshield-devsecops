# Interview Notes

## 1. Explain the project

"I built CloudShield as a cloud DevSecOps lab. I used Terraform to provision an AWS VPC, public subnet, routing, security group, IAM role and EC2 instance. The application is containerized with Docker, Nginx acts as a reverse proxy, and GitHub Actions performs validation, Docker builds, Terraform validation and Trivy vulnerability scanning."

## 2. Why Terraform?

"It makes infrastructure declarative, version-controlled and repeatable. Instead of manually clicking through the AWS console, I can review and recreate infrastructure from code."

## 3. Why Docker?

"It packages the application and dependencies into a consistent runtime environment and makes deployment reproducible."

## 4. Why IAM role?

"An EC2 instance can obtain temporary credentials through its instance profile. This is safer than placing long-lived AWS access keys in application files."

## 5. Why security groups?

"Security groups act as a stateful network firewall around the instance. I allow HTTP publicly and restrict SSH through a configurable CIDR."

## 6. What would you improve for production?

- Private application subnets
- Application Load Balancer
- HTTPS with ACM
- SSM Session Manager instead of public SSH
- NAT gateway or VPC endpoints where appropriate
- RDS in private subnets
- Remote encrypted Terraform state with locking
- Secrets Manager
- WAF
- Auto Scaling
- Multi-AZ design
- Centralized logs and alerts
- CI/CD deployment after approval
