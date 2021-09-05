resource "aws_security_group" "eks-cluster-sg" {
  name        = "${var.env}-eks-sg"
  description = "Eks Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_security_group_rule" "eks-cluster-ingress" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster-sg.id
  to_port           = 443
  type              = "ingress"
}

// Example sec group rules 

resource "aws_security_group_rule" "office-vpn-ingress" {
  count             = var.env == "dev" ? 1 : 0
  cidr_blocks       = ["10.0.0.0/8"]
  description       = "Allow vpn IP to access cluster"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-worker-sg.id
  to_port           = 443
  type              = "ingress"
}