terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  region          = var.region
  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  instance_type    = var.instance_type

  tags = var.tags
}
