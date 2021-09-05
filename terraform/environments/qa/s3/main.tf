module "s3" {
  source                = "../../../modules/s3-package"
  s3_bucket_name        = var.s3_bucket_name
  env                   = var.env
  bucket_prefix         = var.bucket_prefix
  data_expiry           = var.data_expiry
  non_current_data_expi = var.non_current_data_expiry
  s3_admin_role_id      = var.s3_admin_role_id
  aws_root_user_id      = var.aws_root_user_id
}   