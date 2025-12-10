
provider "aws" {
  # Configuration options
  # Tags not to touch during apply
  ignore_tags {
    keys = var.tags_to_ignore
  }
}

resource "aws_s3_bucket" "my-bucket" {
  bucket_prefix = "awsninja5-"
}

resource "aws_s3_object" "object" {
  bucket   = aws_s3_bucket.my-bucket.bucket
  for_each = fileset("${path.module}/messages", "*")
  key      = each.key
  source   = "messages/${each.key}"
}

resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  count                   = var.is_public ? 1 : 0
  bucket                  = aws_s3_bucket.my-bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false

}
resource "aws_s3_bucket_policy" "allow_public_access" {
  count      = var.is_public ? 1 : 0
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