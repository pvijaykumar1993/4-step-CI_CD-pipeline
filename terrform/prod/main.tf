provider "aws" {
  region = us-east-1
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = 10.0.0.0/16
}

resource "aws_instance" "prod_instance" {
  ami             = ami-123
  instance_type   = m6.large
  availability_zone = "us-east-1d"
  subnet_id       = sub-123

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

