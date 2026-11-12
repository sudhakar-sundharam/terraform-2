terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

data "aws_ami" "sydney_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "sydney_server_1" {
  ami               = data.aws_ami.sydney_ami.id
  instance_type     = "t3.micro"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "sydney-server-1"
  }
}

resource "aws_instance" "sydney_server_2" {
  ami               = data.aws_ami.sydney_ami.id
  instance_type     = "t3.micro"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "sydney-server-2"
  }
}

output "sydney_1_public_ip" {
  value = aws_instance.sydney_server_1.public_ip
}

output "sydney_2_public_ip" {
  value = aws_instance.sydney_server_2.public_ip
}
