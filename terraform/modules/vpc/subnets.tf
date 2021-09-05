locals {
    subnet_eks_tags = map(
        "kubernetes.io/cluster/${var.cluster_name}", "shared"
    )
}

resource "aws_subnet" "eks_pub_1a" {
  vpc_id     = aws_vpc.eks-vpc.id
  availability_zone = var.zones[0]
  cidr_block = var.pub_cidr_blocks[0]
  map_public_ip_on_launch = true
  tags = merge(
    local.subnet_eks_tags,
    map(
        "Name", "${var.env}-eks-public-1a",
        "kubernetes.io/role/elb", "1"
    ))
}

resource "aws_subnet" "eks_pub_1b" {
  vpc_id     = aws_vpc.eks-vpc.id
  availability_zone = var.zones[1]
  cidr_block = var.pub_cidr_blocks[1]
  map_public_ip_on_launch = true
  tags = merge(
    local.subnet_eks_tags,
    map(
        "Name", "${var.env}-eks-public-1b",
        "kubernetes.io/role/elb", "1"
    ))
}

resource "aws_subnet" "eks_priv_1c" {
  vpc_id     = aws_vpc.eks-vpc.id
  availability_zone = var.zones[2]
  cidr_block = var.pub_cidr_blocks[2]
  tags = merge(
    local.subnet_eks_tags,
    map(
        "Name", "${var.env}-eks-private-1c",
        "kubernetes.io/role/internal-elb", "1"
    ))
}

resource "aws_subnet" "eks_priv_1d" {
  vpc_id     = aws_vpc.eks-vpc.id
  availability_zone = var.zones[3]
  cidr_block = var.pub_cidr_blocks[3]
  tags = merge(
    local.subnet_eks_tags,
    map(
        "Name", "${var.env}-eks-private-1d",
        "kubernetes.io/role/internal-elb", "1"
    ))
}
