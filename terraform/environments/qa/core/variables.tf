variable "env" {
  default = "qa"
  type    = string
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  type    = string
}

variable "cluster_name" {
  default = "qa-cluster"
}

variable "zones" {
  type = list
  default = ["us-east-1a","us-east-1b","us-east-1c", "us-east-1c"]
}

variable "pub_cidr_blocks" {
  type = list
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.4.0/24","10.0.6.0/24"]
}