# Output the public IP address of our EC2 instance
output "public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

# Output the public DNS name 
output "public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web_server.public_dns
}

# Output the website URL
output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}

# Output the SSH connection command
output "ssh_command" {
  description = "Command to SSH into the server"
  value       = "ssh -i ~/.ssh/afriture_lab_key ec2-user@${aws_instance.web_server.public_ip}"
}

# Output the instance ID for reference
output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web_server.id
}

# Output the security group ID
output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web_sg.id
}