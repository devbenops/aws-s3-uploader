
variable "env" {
  description = "Environment tag of the sec group"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_grp_name" {
  description = "Name of the node group"
  type        = string
}

variable "eks_subnet_ids" {
  description = "subnets created for the eks cluster and nodes"
  type        = list
}

variable "worker_nodes_sg_ids" {
  description = "Sg ids for worker nodes"
  #type        = string
}
variable "instance_ami_type" {
  description = "AMI type used for ec2 instances in the node group"
  type        = string
}

variable "instance_disk_size" {
  description = "Disk size of the ec2 instance"
  type        = string
}

variable "instance_types" {
  description = "Types of instances for the node group"
  type        = list
}

variable "instance_ssh_key_pair" {
  description = "Key pair name for the ssh access"
  type        = string
}

variable "eks_node_k8s_version" {
  description = "Kubernetes version of the cluster and nodes"
  type        = string
}

variable "eks_nodes_arn" {
  description = "Role arn of the node group"
  type        = string
}

variable "eks_nodes_depends_on" {
  type        = any
  default     = []
  description = "A variable to define depends_on"
}

variable "desired_node_count" {
  description = "Desired count of nodes in the cluster"
  type        = number
}

variable "max_node_count" {
  description = "Maximum number of nodes"
  type        = number
}

variable "min_node_count" {
  description = "Minimum number of nodes"
  type        = number
}

variable "nodegroup_create_timeouts" {
  description = "Timeout value for node group creation"
  type        = string
}

variable "nodegroup_delete_timeouts" {
  description = "Timeout value for node group creation"
  type        = string
}