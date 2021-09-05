module "eks_iam_global" {
  source                     = "../../modules/global-iam"

  aws_iam_role_eks_cluster   = var.aws_iam_role_eks_cluster
  iam_role_worker_nodes      = var.iam_role_worker_nodes
  s3_bucket_qa_name          = var.s3_bucket_qa_name
  s3_bucket_stage_name       = var.s3_bucket_stage_name
}
