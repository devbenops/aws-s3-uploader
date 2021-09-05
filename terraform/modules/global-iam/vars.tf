variable "aws_iam_role_eks_cluster" {
  description = "IAM role created for eks cluster"
  type        = string
}

variable "iam_role_worker_nodes" {
  description = "IAM role created for eks worker nodes"
  type        = string
}

variable "s3_bucket_qa_name" {
  description = "Name of the s3 QA bucket"
  type        = string
}

variable "s3_bucket_stage_name" {
  description = "Name of the s3 staging bucket"
  type        = string
}