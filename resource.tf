# tfsec:ignore:aws-ec2-no-public-ingress-sgr
# tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "web_sg" {
name = "web-sg"
description = "Allow HTTP traffic from VPC"

  ingress {
    description = "HTTP from VPC"
    from_port = var.server_http_port
    to_port   = var.server_http_port
    protocol = "tcp"
    cidr_blocks = ["${var.tester_ip}/32"]
  }
  egress {
    description = "All outbound"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags =  {
    Name = "web-sg"
  }
}

resource "aws_instance" "ec2-instance" {
  ami = "ami-02b8269d5e85954ef"
  instance_type = "t2.micro"

    root_block_device {
      encrypted = true  
    }

    metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  subnet_id = "subnet-01a456c8f9df7db15"
  associate_public_ip_address = true

  key_name = "ec2-demo"

  tags = {
    Name = "testing-busybox-server"
  }
    user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install busybox -y
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_http_port} &
    EOF
}