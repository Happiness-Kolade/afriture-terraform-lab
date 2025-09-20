# Security Group - Acts as a firewall for the EC2 instance
resource "aws_security_group" "web_sg" {
  name_prefix = "afriture-lab-sg"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic (port 80) from anywhere on the internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic (port 443) from anywhere on the internet  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (port 22) from my IP address - for deployment and troubleshooting
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["197.211.59.187/32"]
  }

  # Allow all outbound traffic - server needs to download packages, etc.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "afriture-lab-security-group"
  }
}

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance - Our web server
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name              = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id             = var.subnet_id

  # User data script - runs when the instance first boots
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd git
    systemctl start httpd
    systemctl enable httpd
    
    # Create a simple HTML page
    echo "<h1>Afriture Lab - Terraform + GitHub Actions</h1>" > /var/www/html/index.html
    echo "<p>Server deployed successfully!</p>" >> /var/www/html/index.html
    echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html
  EOF

  tags = {
    Name = "afriture-lab-web-server"
  }
}