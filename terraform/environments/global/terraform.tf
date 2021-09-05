terraform {
  backend "s3" {
    bucket = "eks-demo-101"
    key    = "terraform-state/global-eks-iam/eks-iam.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
  }
}