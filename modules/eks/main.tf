provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = var.tags
}

module "eks_blueprints" {
  source  = "aws-ia/eks-blueprints/aws"
  version = "4.0.2"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
      subnet_ids     = module.vpc.private_subnets
    }
  }

  enable_irsa = true

  tags = var.tags
}

module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.1.0"

  cluster_name      = module.eks_blueprints.eks_cluster_id
  cluster_endpoint  = module.eks_blueprints.eks_cluster_endpoint
  cluster_version   = var.cluster_version
  oidc_provider_arn = module.eks_blueprints.oidc_provider_arn

  eks_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
    aws-load-balancer-controller = {
      most_recent = true
    }
    metrics-server = {
      most_recent = true
    }
  }

  tags = var.tags
}
