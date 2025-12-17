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


# import {
#   to = aws_s3_bucket.to_import
#   id = data.aws_s3_bucket.to_import.id
# }

# data "aws_s3_bucket" "to_import" {
#   bucket = "awsninja5-to-import-1"

# }
