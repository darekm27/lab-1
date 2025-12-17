terraform {
  required_version = "~>1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

provider "aws" {

}

variable "name_prefix" {
  type    = string
  default = "awsninja5"
}

variable "server_version" {
  type = string
  validation {
    condition = var.server_version == "1" || var.server_version == "2"
    error_message = "Wrong version"
  }
}

data "aws_ami" "server_ami" {
  filter {
    name = "name"
    values = [ "ubuntu-linux-apache-${var.server_version}-*" ]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.server_ami.id
  instance_type = "t2.nano"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  tags = {
    Name = "${var.name_prefix}-app-server"
  }
}

resource "aws_security_group" "allow_all" {
  name = "${var.name_prefix}-public-accaess"
  ingress {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [ "::/0" ]
    }
  
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [ "::/0" ]
    }
}

output "server_ip" {
  value = aws_instance.app_server.public_ip
}