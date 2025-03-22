variable "aws_region" {
  description = "AWS region"
  default     = "us-west-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string 
}