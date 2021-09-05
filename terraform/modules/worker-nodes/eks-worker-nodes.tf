resource "aws_eks_node_group" "eks-nodes" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.node_grp_name
  node_role_arn   = var.eks_nodes_arn
  subnet_ids      = var.eks_subnet_ids
  ami_type        = var.instance_ami_type
  disk_size       = var.instance_disk_size
  instance_types  = var.instance_types
  version         = var.eks_node_k8s_version
  
  scaling_config {
    desired_size = var.desired_node_count
    max_size     = var.max_node_count
    min_size     = var.min_node_count
  }

  timeouts {
    create = var.nodegroup_create_timeouts
    delete = var.nodegroup_delete_timeouts
  }

  depends_on = [var.eks_nodes_depends_on]

  tags = map(
    "Name", "${var.env}-eksnode",
  )

  remote_access {
    ec2_ssh_key               = var.instance_ssh_key_pair
    source_security_group_ids = [var.worker_nodes_sg_ids]
  }
}
