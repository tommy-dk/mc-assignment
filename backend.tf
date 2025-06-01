terraform {
  backend "s3" {
    bucket  = "terraform-state"
    key     = "eks-mastercard/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
