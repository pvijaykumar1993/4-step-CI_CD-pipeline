# /infrastructure/qa/main.tf
provider "aws" {
  region = us-east-1
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = 10.0.0.0/16
}

resource "aws_instance" "qa_instance" {
  ami             = ami-123
  instance_type   = m6.large
  availability_zone = "us-east-1b"
  subnet_id       = sub-123

  tags = {
    Name = "QA Instance"
  }
}

output "qa_instance_id" {
  value = aws_instance.qa_instance.id
}
