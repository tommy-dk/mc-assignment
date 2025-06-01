# General
region         = "eu-west-1"
environment    = "dev"
cluster_name   = "eks-dev-cluster"

# VPC
vpc_cidr_block = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
azs           = ["eu-west-1a", "eu-west-1b"]

# EKS
desired_capacity = 2
max_size         = 3
min_size         = 1
instance_type    = "t3.medium"

# Tags
tags = {
  Environment = "dev"
  Project     = "eks-demo"
  Owner       = "Tommy"
}
