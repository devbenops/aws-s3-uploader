variable "env" {
  default = "qa"
  type    = string
}

variable "s3_bucket_name" {
  default = "qa-nithin-paul-platform-challenge"
  type    = string
}
variable "bucket_prefix" {
  default = "data_store/"
  type    = string
}

variable "data_expiry" {
  default = 1
  type    = number
}

variable "non_current_data_expiry" {
  default = 1
  type    = number
}

variable "kms_key_id" {
  default = "ARN of the KMS key"
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "s3_admin_role_id" {
  default = "AROAsampleid"
  type    = string
}

variable "aws_root_user_id" {
  default = "111111111111"
  type    = string
}
