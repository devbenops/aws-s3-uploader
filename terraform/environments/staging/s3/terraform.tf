terraform {
  backend "s3" {
    bucket         = "eks-demo-101"
    key            = "terraform-state/qa/s3.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
  }
}