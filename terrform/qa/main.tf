# /infrastructure/qa/main.tf
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = var.vpc_cidr
}

resource "aws_instance" "qa_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  availability_zone = "us-east-1b"
  subnet_id       = module.vpc.subnet_id

  tags = {
    Name = "QA Instance"
  }
}

output "qa_instance_id" {
  value = aws_instance.qa_instance.id
}
