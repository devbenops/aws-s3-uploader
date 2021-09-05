output "eks_vpc_id" {
  value = aws_vpc.eks-vpc.id
}

output "eks_subnet_pub_1a" {
  value = aws_subnet.eks_pub_1a.id
}

output "eks_subnet_pub_1b" {
  value = aws_subnet.eks_pub_1b.id
}

output "eks_subnet_priv_1c" {
  value = aws_subnet.eks_priv_1c.id
}

output "eks_subnet_priv_1d" {
  value = aws_subnet.eks_priv_1d.id
}