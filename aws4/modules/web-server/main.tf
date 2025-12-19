locals {
  tag_key_name = "${var.name_prefix}-app-server"
}

data "aws_ami" "server_ami" {
  filter {
    name   = "name"
    values = ["ubuntu-linux-apache-${var.server_version}-*"]
  }
}

resource "random_shuffle" "subnets" {
  input = var.subnet_ids
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t3.micro"
  count                  = var.number_of_servers
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  tags = {
    Name = "${local.tag_key_name}-${count.index}"
  }
  subnet_id = random_shuffle.subnets.result[count.index]
}

resource "aws_security_group" "allow_all" {
  name = "${var.name_prefix}-public-accaess"
  vpc_id = var.vpc_id
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

