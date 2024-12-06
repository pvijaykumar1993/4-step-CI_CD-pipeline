provider "aws" {
  region = us-east-1
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = 10.0.0.0/16
}

resource "aws_instance" "dev_instance" {
  ami             = ami-123
  instance_type   = m6.large
  availability_zone = "us-east-1a"
  subnet_id       = sub-123

  tags = {
    Name = "Dev Instance"
  }
}

output "dev_instance_id" {
  value = aws_instance.dev_instance.id
}
