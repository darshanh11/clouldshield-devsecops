output "instance_public_ip" {
  description = "Public IP of the CloudShield EC2 instance"
  value       = aws_instance.app.public_ip
}

output "application_url" {
  description = "Application URL"
  value       = "http://${aws_instance.app.public_ip}"
}

output "health_url" {
  description = "Health endpoint"
  value       = "http://${aws_instance.app.public_ip}/health"
}
