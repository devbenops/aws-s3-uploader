output "eks_vpc_id" {
  value = module.eks-vpc.eks_vpc_id
}

output "eks_subnet_pub_1a" {
    value = module.eks-vpc.eks_subnet_pub_1a
}

output "eks_subnet_pub_1b" {
    value = module.eks-vpc.eks_subnet_pub_1b
}

output "eks_subnet_priv_1c" {
    value = module.eks-vpc.eks_subnet_priv_1c
}

output "eks_subnet_priv_1d" {
    value = module.eks-vpc.eks_subnet_priv_1d
}

output "eks_cluster_sg" {
  value = module.eks-sg.eks_cluster_sg
}

output "eks_worker_sg" {
  value = module.eks-sg.eks_worker_sg
}