module "eks-vpc" {
  source            = "../../../modules/vpc"

  vpc_cidr_block    = var.vpc_cidr_block
  aws_region        = var.aws_region
  zones             = var.zones
  env               = var.env
  pub_cidr_blocks   = var.pub_cidr_blocks
  cluster_name      = var.cluster_name
}

module "eks-sg" {
  source             = "../../../modules/eks-sg"
  
  vpc_id             = module.eks-vpc.eks_vpc_id
  env                = var.env
}