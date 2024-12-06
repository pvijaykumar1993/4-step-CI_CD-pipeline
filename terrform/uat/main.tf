provider "aws" {
  region = us-east-1
}

module "vpc" {
  source = "../modules/vpc"
  cidr_block = 10.0.0.0/16
}

resource "aws_instance" "uat_instance" {
  ami             = ami.123
  instance_type   = m6.large
  availability_zone = "us-east-1c"
  subnet_id       = sub-123

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

