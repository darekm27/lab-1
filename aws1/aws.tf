terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = "awsninja5-"
}

output "bucket-name" {
  value = aws_s3_bucket.my-bucket.bucket
}

resource "aws_s3_object" "object" {
  bucket   = aws_s3_bucket.my-bucket.bucket
  for_each = fileset("${path.module}/messages", "*")
  key      = each.key
  source   = "messages/${each.key}"
}

# Input - Bucket prefix jako zmienna + domyślnie Twój
# Input - Tagi, gdzie domyślnie jest w variable "purpose": "learning" (może byc nadpisane)
# Zawsze dodany tag "owner" (do bucketu lub wszędzie (default tags))
# Output: bucket ARN i Url
