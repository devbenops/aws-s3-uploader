variable "env" {
  default = "staging"
  type    = string
}

variable "aws_region" {
  default = "eu-west-1"
  type    = string
}

variable "vpc_cidr_block" {
  default = "10.7.0.0/16"
  type    = string
}

variable "cluster_name" {
  default = "staging-cluster"
}

variable "zones" {
  type = list
  default = ["eu-west-1a","eu-west-1b","eu-west-1c", "eu-west-1c"]
}


variable "pub_cidr_blocks" {
  type = list
  default = ["10.7.0.0/24","10.7.2.0/24","10.7.4.0/24", "10.7.6.0/24"]
}
