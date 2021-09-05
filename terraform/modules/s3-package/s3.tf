
resource "aws_s3_bucket" "s3_uploader" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.env
  }
  versioning {
    enabled = true
  }
  lifecycle_rule {
    prefix  = var.bucket_prefix
    enabled = true
    expiration {
      days = var.data_expiry
    }
    noncurrent_version_expiration {
      days = var.non_current_data_expiry
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


resource "aws_s3_bucket_public_access_block" "s3_uploader" {
  bucket = aws_s3_bucket.s3_uploader.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_s3_bucket_policy" "s3_uploader" {
  bucket = aws_s3_bucket.s3_uploader.id
  policy = <<POLICY
{   
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${var.s3_bucket_name}",
        "arn:aws:s3:::${var.s3_bucket_name}/*"
      ],
      "Condition": {
        "StringNotLike": {
          "aws:userId": [
            "${var.s3_admin_role_id}:*",
            "${var.aws_root_user_id}"
          ]
        }
      }
    }
  ]
}
  
POLICY
}