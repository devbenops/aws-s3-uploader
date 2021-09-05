resource "aws_nat_gateway" "eks_nat_gw1" {

  allocation_id = aws_eip.nat-eip1.id
  subnet_id = aws_subnet.eks_pub_1a.id

  tags = {
    Name = "${var.env}-nat-1"
  }
}

resource "aws_nat_gateway" "eks_nat_gw2" {

  allocation_id = aws_eip.nat-eip2.id
  subnet_id = aws_subnet.eks_pub_1b.id

  tags = {
    Name = "${var.env}-nat-2"
  }
}