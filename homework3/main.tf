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
  default_tags {
    tags = {
      "owner" = "awsninja5"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private-subnet" {
  value = aws_subnet.private-subnet.id
}

output "public-subnet" {
  value = aws_subnet.public-subnet.id
}
