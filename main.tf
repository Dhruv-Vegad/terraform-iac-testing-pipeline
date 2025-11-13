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
  region = "ap-south-1"
}

variable "server_http_port" {
    description = "The Port for the server"
    type = number
    default = 8080
}

variable "region" {
  description = "region specified here"
    type = string
  default = "ap-south-1"
}

output "aws_region"{
    value = var.region
}

output "instance_public_ip" {
  description = "Public IP address of the web server."
  value       = aws_instance.ec2-instance.public_ip
}