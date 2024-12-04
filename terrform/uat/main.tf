provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = var.vpc_cidr
}

resource "aws_instance" "uat_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  availability_zone = "us-east-1c"
  subnet_id       = module.vpc.subnet_id

  tags = {
    Name = "UAT Instance"
  }
}

output "uat_instance_id" {
  value = aws_instance.uat_instance.id
}

output "uat_instance_public_ip" {
  value = aws_instance.uat_instance.public_ip
}

