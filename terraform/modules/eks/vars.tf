variable "cluster-name" {
  description = "EKS cluster name"
  type    = string
}

variable "vpc_id" {
  description = "vpc id of the eks cluster"
  type    = string
}

variable "eks_subnet_ids" {
  description = "subnet ids of eks VPC"
  type    = list
}

variable "eks_k8s_version" {
  description = "Kubernetes version of the EKS cluster"
  type    = string
}

variable "eks_cluster_sg_ids" {
  description = "Security group associated for the eks cluster access"
}

variable "eks_cluster_role_arn" {
  description = "ARN of the eks cluster role"
  type    = string
}

variable "cluster_create_timeouts" {
  description = "Timeout value during eks cluster creation"
  type = string
}

variable "cluster_delete_timeouts" {
  description = "Timeout value during eks cluster deletion"
  type = string
}
