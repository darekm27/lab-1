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

resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket                  = aws_s3_bucket.my-bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false

}
resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket     = aws_s3_bucket.my-bucket.id
  policy     = data.aws_iam_policy_document.allow_public_access.json
  depends_on = [aws_s3_bucket_public_access_block.allow_public_access]
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "*"
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.my-bucket.arn,
      "${aws_s3_bucket.my-bucket.arn}/*",
    ]
  }
}