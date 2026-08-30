variable "aws_region" {
  description = "AWS region for the lab"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource tags"
  type        = string
  default     = "cloudshield"
}

variable "admin_cidr" {
  description = "CIDR allowed to SSH to the EC2 instance. Replace with your public IP/32."
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
