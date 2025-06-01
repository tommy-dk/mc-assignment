output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks_blueprints.eks_cluster_id
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks_blueprints.eks_cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = module.eks_blueprints.eks_cluster_certificate_authority_data
}
