data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "eks-demo-101"
    key    = "terraform-state/staging/core.tfstates"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "global-iam" {
  backend = "s3"
  config = {
    bucket = "eks-demo-101"
    key    = "terraform-state/global-eks-iam/eks-iam.tfstate"
    region = "eu-central-1"
  }
}

locals {
  prefix    = "staging-"
}

// Create EKS cluster in staging environment

module "eks_cluster" {
  source = "../modules/eks"

  cluster-name             = "${local.prefix}cluster"
  eks_k8s_version          = var.eks_k8s_version
  cluster_create_timeouts  = var.cluster_create_timeouts
  cluster_delete_timeouts  = var.cluster_delete_timeouts
  vpc_id                   = data.terraform_remote_state.vpc.outputs.eks_vpc_id
  eks_cluster_sg_ids       = data.terraform_remote_state.vpc.outputs.eks_cluster_sg
  eks_cluster_role_arn     = data.terraform_remote_state.global-iam.outputs.eks_cluster_role_arn

  eks_subnet_ids  = [ 
    data.terraform_remote_state.vpc.outputs.eks_subnet_pub_1a,
    data.terraform_remote_state.vpc.outputs.eks_subnet_pub_1b,
    data.terraform_remote_state.vpc.outputs.eks_subnet_pub_1b,
  ]  

}


// Create worker nodes for staging EKS cluster

module "eks_worker_nodes" {
  source = "../modules/worker-nodes"

  node_grp_name             = "${local.prefix}node-group"
  eks_node_k8s_version      = module.eks_cluster.eks_k8s_version
  instance_ssh_key_pair     = var.instance_ssh_key_pair
  instance_ami_type         = var.instance_ami_type
  instance_disk_size        = var.instance_disk_size
  instance_types            = var.instance_types
  desired_node_count        = var.desired_node_count
  max_node_count            = var.max_node_count
  min_node_count            = var.min_node_count
  env                       = var.env
  nodegroup_create_timeouts = var.nodegroup_create_timeouts
  nodegroup_delete_timeouts = var.nodegroup_delete_timeouts
  eks_cluster_name          = module.eks_cluster.eks_cluster_name
  worker_nodes_sg_ids       = data.terraform_remote_state.vpc.outputs.eks_worker_sg
  eks_nodes_arn             = data.terraform_remote_state.global-iam.outputs.eks_nodes_role_arn
  eks_nodes_depends_on      = module.eks_cluster.eks_cluster_name
 
  eks_subnet_ids  = [ 
    data.terraform_remote_state.vpc.outputs.eks_subnet_pub_1a,
    data.terraform_remote_state.vpc.outputs.eks_subnet_pub_1b,
    data.terraform_remote_state.vpc.outputs.eks_subnet_pub_1b,
  ]  

}