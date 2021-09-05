//   Elastic IP for the NAT GW may require IGW to exist prior to association. 


resource "aws_eip" "nat-eip1" {
  depends_on = [aws_internet_gateway.eks-igw]
}

resource "aws_eip" "nat-eip2" {
  depends_on = [aws_internet_gateway.eks-igw]
}