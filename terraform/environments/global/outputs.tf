output "eks_cluster_role_arn" {
    value = module.eks_iam_global.eks_cluster_role_arn
}

output "eks_nodes_role_arn" {
    value = module.eks_iam_global.eks_nodes_role_arn
}