output "eks_cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}

output "eks_k8s_version" {
    value = aws_eks_cluster.eks-cluster.version
}