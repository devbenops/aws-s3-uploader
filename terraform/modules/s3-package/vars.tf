variable "env" {
  description = "Environment tag of the s3 bucket group"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the bucket"
  type        = string
}
variable "bucket_prefix" {
  description = "Folder prefix for lifecycle rule"
  type        = string
}

variable "data_expiry" {
  description = "Number of days the data to be stored in s3"
  type        = number
}

variable "non_current_data_expiry" {
  description = "Number of days the  versioned non current data to be stored in s3"
  type        = number
}

variable "kms_key_id" {
  description = "ARN of the KMS key"
  type        = string
}

variable "s3_admin_role_id" {
  description = "Role id for granting s3 access"
  type        = string
}

variable "aws_root_user_id" {
  description = "AWS account root ID"
  type        = string
}



