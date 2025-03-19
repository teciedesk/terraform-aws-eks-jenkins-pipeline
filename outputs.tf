output "cluster_name" {
  description = "EKS Cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  description = "EKS Cluster Certificate Authority Data"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}
