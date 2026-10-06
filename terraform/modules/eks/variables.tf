# ============================================================
# nearBy - EKS MODULE VARIABLES
# ============================================================

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS"
  type        = list(string)
}

variable "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  type        = string
}

variable "eks_security_group_id" {
  description = "Security group for EKS"
  type        = string
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS nodes"
  type        = list(string)

  default = [
    "t3.medium"
  ]
}

variable "desired_nodes" {
  description = "Desired number of EKS nodes"
  type        = number
  default     = 2
}

variable "min_nodes" {
  description = "Minimum number of EKS nodes"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of EKS nodes"
  type        = number
  default     = 3
}