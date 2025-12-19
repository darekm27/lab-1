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

locals {
  tag_key_name = "${var.name_prefix}-app-server"
}

variable "name_prefix" {
  type    = string
  default = "awsninja5"
}

variable "server_version" {
  type = string
  validation {
    condition     = var.server_version == "1" || var.server_version == "2"
    error_message = "Wrong version"
  }
}

variable "number_of_servers" {
  type    = number
  default = 2
}

data "aws_ami" "server_ami" {
  filter {
    name   = "name"
    values = ["ubuntu-linux-apache-${var.server_version}-*"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t3.micro"
  count                  = var.number_of_servers
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  tags = {
    Name = "${local.tag_key_name}-${count.index}"
  }
}

resource "aws_security_group" "allow_all" {
  name = "${var.name_prefix}-public-accaess"
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "server_ip" {
  value = formatlist(
    "%s - %s",
    aws_instance.app_server[*].tags["Name"],
    aws_instance.app_server[*].public_ip
  )
}