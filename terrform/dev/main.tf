provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = var.vpc_cidr
}

resource "aws_instance" "dev_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  availability_zone = "us-east-1a"
  subnet_id       = module.vpc.subnet_id

  tags = {
    Name = "Dev Instance"
  }
}

output "dev_instance_id" {
  value = aws_instance.dev_instance.id
}
