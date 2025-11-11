terraform{
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

resource "aws_instance" "infra-ec2-instance" {
    ami           = "ami-02b8269d5e85954ef"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "auto-infra-project-s3" {
    bucket = "auto-infra-project-bucket-s3"
}

resource "aws_s3_bucket_versioning" "versioning" {
    bucket = "auto-infra-project-bucket-s3"
    versioning_configuration {
      status = "Enabled"
    }
}
