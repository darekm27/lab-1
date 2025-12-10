terraform {
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
  # Configuration options
}

variable "bucket_prefix" {
  type        = string
  description = "S3 Bucket name prefix"
  default     = "awsninja5-"
}

variable "tags" {
  type        = map(string)
  description = "Tags for S3 bucket"
  default = {
    "purpose" = "learning"
  }
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = var.bucket_prefix
  tags          = var.tags
}

output "result" {
  value = "ARN = ${aws_s3_bucket.my-bucket.arn}\nUrl = ${aws_s3_bucket.my-bucket.bucket_domain_name}"
}
