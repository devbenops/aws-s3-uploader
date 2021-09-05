resource "aws_route_table_association" "eks-public1" {
  subnet_id = aws_subnet.eks_pub_1a.id
  route_table_id = aws_route_table.eks-public.id
}

resource "aws_route_table_association" "eks-public2" {
  subnet_id = aws_subnet.eks_pub_1b.id
  route_table_id = aws_route_table.eks-public.id
}

resource "aws_route_table_association" "eks-private1" {
  subnet_id = aws_subnet.eks_priv_1c.id
  route_table_id = aws_route_table.eks-private1.id
}

resource "aws_route_table_association" "eks-private2" {
  subnet_id = aws_subnet.eks_priv_1d.id
  route_table_id = aws_route_table.eks-private2.id
}