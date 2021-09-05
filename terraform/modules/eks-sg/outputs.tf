output "eks_cluster_sg" {
  value = aws_security_group.eks-cluster-sg.id
}

output "eks_worker_sg" {
  value = aws_security_group.eks-worker-sg.id
}