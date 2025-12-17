# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "awsninja5-to-import-1"
resource "aws_s3_bucket" "to_import" {
  bucket              = "awsninja5-to-import-1"
  force_destroy       = false
  object_lock_enabled = false
  region              = "us-east-1"
  tags = {
    owner = "awsninja5"
  }
  tags_all = {
    owner = "awsninja5"
  }
}
