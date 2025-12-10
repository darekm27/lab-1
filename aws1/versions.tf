terraform {
  required_version = "~>1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }

  backend "s3" {
    bucket       = "awsninja5-state"
    key          = "state"
    region       = "us-east-1"
    use_lockfile = true
  }
}