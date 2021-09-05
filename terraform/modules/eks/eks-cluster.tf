resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = var.eks_cluster_role_arn
  version  = var.eks_k8s_version

  vpc_config {
    security_group_ids = [var.eks_cluster_sg_ids]
    subnet_ids         = var.eks_subnet_ids
  }

  timeouts {
    create = var.cluster_create_timeouts
    delete = var.cluster_delete_timeouts
  }
}
