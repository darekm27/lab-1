terraform {
  required_version = "~>1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

variable "name_prefix" {
  type = string
  default = "awsninja5"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  name = "${var.name_prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  map_public_ip_on_launch = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "web_server" {
  source = "./modules/web-server"
  server_version = "1"
  number_of_servers = 3
  name_prefix = var.name_prefix
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

output "servers" {
  value = module.web_server.server_ip
}