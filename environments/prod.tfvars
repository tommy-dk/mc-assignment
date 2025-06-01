# General
region         = "eu-west-1"
environment    = "prod"
cluster_name   = "eks-prod-cluster"

# VPC
vpc_cidr_block = "10.1.0.0/16"
public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnets = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
azs           = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

# All 3 availability zones will be used for full reliability

# EKS
desired_capacity = 4
max_size         = 6
min_size         = 3
instance_type    = "m5.large"

## Larger instance type and more of them because we're in prod

# Tags
tags = {
  Environment = "prod"
  Project     = "eks-prod"
  Owner       = "platform-team"
}
