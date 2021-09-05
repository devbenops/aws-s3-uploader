resource "aws_security_group" "eks-worker-sg" {
  name        = "${var.env}-eks-worker-sg"
  description = "SG for nodes in the EKS cluster"
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

resource "aws_security_group_rule" "eks-worker-node-ingress" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation IP to access EKS nodes"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-worker-sg.id
  to_port           = 22
  type              = "ingress"
}

// Example sec group rules 

resource "aws_security_group_rule" "node-group-office-vpn" {
  count             = var.env == "dev" ? 1 : 0
  cidr_blocks       = ["10.0.0.0/8"]
  description       = "Allow vpn ip 1 IP-1 to access EKS nodes"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-worker-sg.id
  to_port           = 22
  type              = "ingress"
}

// Example sec group rules 
resource "aws_security_group_rule" "node-group-office-vpn1" {
  count             = var.env == "staging" ? 1 : 0
  cidr_blocks       = ["20.0.0.0/8"]
  description       = "Allow vpn IP-2 to access EKS nodes"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-worker-sg.id
  to_port           = 22
  type              = "ingress"
}