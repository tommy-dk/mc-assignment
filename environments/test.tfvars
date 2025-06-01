# General
region         = "eu-west-1"
environment    = "test"
cluster_name   = "eks-test-cluster"

# VPC
vpc_cidr_block = "10.0.100.0/16"
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
private_subnets = ["10.0.103.0/24", "10.0.104.0/24"]
azs            = ["eu-west-1a", "eu-west-1b"]

# EKS
desired_capacity = 3
max_size         = 4
min_size         = 2
instance_type    = "t3.large"

# Tags
tags = {
  Environment    = "test"
  Project        = "eks-blueprint-demo"
  Owner          = "qa-team"
  Purpose        = "integration-tests"
}
