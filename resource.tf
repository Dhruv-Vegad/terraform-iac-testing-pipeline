resource "aws_security_group" "web_sg" {
  ingress = {
    from_port = var.server_http_port
    to_port   = var.server_http_port
    protocol = "tcp"
    cidr_blocks = ["10.2.0.0/16"]
  }
  egress = {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-0016dcd3c5ec3c94d"
  instance_type = "t2.micro"


  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  
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