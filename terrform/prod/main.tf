provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = var.vpc_cidr
}

resource "aws_instance" "prod_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  availability_zone = "us-east-1d"
  subnet_id       = module.vpc.subnet_id

  tags = {
    Name = "Prod Instance"
  }
}

output "prod_instance_id" {
  value = aws_instance.prod_instance.id
}

output "prod_instance_public_ip" {
  value = aws_instance.prod_instance.public_ip
}

