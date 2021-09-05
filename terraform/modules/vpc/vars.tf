variable "env" {
  description = "Environment tag of the sec group"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the eks cluster"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block used in the VPC"
  type        = string
}

variable "pub_cidr_blocks" {
  description = "Public subnet cidr block"
  type        = list
}

variable "zones" {
  description = "List aws availability zones used for the eks cluster"
  type        = list
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}