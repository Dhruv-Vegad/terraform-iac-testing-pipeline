terraform{
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
    
    backend "s3" {
    bucket = "Auto_infra_by_terraform_project"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "state_locking_table"
    }
}

provider "aws" {
  region = var.region
}


output "aws_region"{
    value = var.region
}

output "instance_public_ip" {
  description = "Public IP address of the web server."
  value       = aws_instance.ec2-instance.public_ip
}

output "server_port" {
  value = var.server_http_port
}