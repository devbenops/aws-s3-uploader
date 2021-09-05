resource "aws_route_table" "eks-public" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "eks-private1" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gw1.id
  }

  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "eks-private2" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.eks_nat_gw2.id
  }

  tags = {
    Name = "private2"
  }
}
