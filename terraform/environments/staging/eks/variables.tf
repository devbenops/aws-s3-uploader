variable "aws_region" {
  default = "eu-west-1"
  type    = string
}

variable "env" {
  default = "dev"
  type    = string
}

variable "instance_ami_type" {
  default = "AL2_x86_64"
  type    = string
}

variable "instance_disk_size" {
  default = 20
  type    = number
}

variable "instance_types" {
  default = ["t3.medium"]
  type    = list
}


variable "eks_k8s_version" {
  default = 1.18
  type    = number
}

variable "instance_ssh_key_pair" {
  default = "staging-ssh-key"
  type    = string
}

variable "cluster_create_timeouts" {
  default = "60m"
  type = string
}

variable "cluster_delete_timeouts" {
  default = "30m"
  type = string
}

variable "desired_node_count" {
  default     = 3
  type        = number
}

variable "max_node_count" {
  default     = 4
  type        = number
}

variable "min_node_count" {
  default     = 2
  type        = number
}

variable "nodegroup_create_timeouts" {
  default     = "1h"
  type        = string
}

variable "nodegroup_delete_timeouts" {
  default     = "30m"
  type        = string
}