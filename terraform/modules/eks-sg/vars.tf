variable "vpc_id" {
  description = "VPC id of the EKS cluster"
  type        = string
}

variable "env" {
  description = "Environment tag of the sec group"
  type        = string
}
