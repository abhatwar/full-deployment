# ============================================================
# SUMO PRODUCTION - OUTPUTS
# ============================================================


# ------------------------------------------------------------
# VPC ID
# ------------------------------------------------------------

output "vpc_id" {

  description = "Production VPC ID"

  value = module.vpc.vpc_id
}


# ------------------------------------------------------------
# VPC CIDR
# ------------------------------------------------------------

output "vpc_cidr" {

  description = "Production VPC CIDR"

  value = module.vpc.vpc_cidr
}


# ------------------------------------------------------------
# PUBLIC SUBNETS
# ------------------------------------------------------------

output "public_subnet_ids" {

  description = "Production public subnet IDs"

  value = module.vpc.public_subnet_ids
}


# ------------------------------------------------------------
# PRIVATE SUBNETS
# ------------------------------------------------------------

output "private_subnet_ids" {

  description = "Production private subnet IDs"

  value = module.vpc.private_subnet_ids
}


# ------------------------------------------------------------
# INTERNET GATEWAY
# ------------------------------------------------------------

output "internet_gateway_id" {

  description = "Production Internet Gateway ID"

  value = module.vpc.internet_gateway_id
}


# ------------------------------------------------------------
# NAT GATEWAY
# ------------------------------------------------------------

output "nat_gateway_id" {

  description = "Production NAT Gateway ID"

  value = module.vpc.nat_gateway_id
}

output "alb_security_group_id" {

  description = "Production ALB security group"

  value = module.security_groups.alb_security_group_id
}


output "eks_security_group_id" {

  description = "Production EKS security group"

  value = module.security_groups.eks_security_group_id
}


output "rds_security_group_id" {

  description = "Production RDS security group"

  value = module.security_groups.rds_security_group_id
}


# ============================================================
# IAM OUTPUTS
# ============================================================

output "eks_cluster_role_arn" {

  description = "Production EKS cluster IAM role ARN"

  value = module.iam.eks_cluster_role_arn
}


output "eks_node_role_arn" {

  description = "Production EKS node IAM role ARN"

  value = module.iam.eks_node_role_arn
}


# ============================================================
# ECR OUTPUTS
# ============================================================

output "ecr_repository_url" {

  description = "Production ECR repository URL"

  value = module.ecr.repository_url
}


output "ecr_repository_arn" {

  description = "Production ECR repository ARN"

  value = module.ecr.repository_arn
}


output "ecr_repository_name" {

  description = "Production ECR repository name"

  value = module.ecr.repository_name
}

# ============================================================
# EKS OUTPUTS
# ============================================================

output "eks_cluster_name" {

  description = "Production EKS cluster name"

  value = module.eks.cluster_name
}


output "eks_cluster_endpoint" {

  description = "Production EKS cluster endpoint"

  value = module.eks.cluster_endpoint
}


output "eks_node_group_name" {

  description = "Production EKS node group"

  value = module.eks.node_group_name
}

# ============================================================
# S3 OUTPUTS
# ============================================================

output "s3_bucket_name" {

  description = "Production S3 bucket"

  value = module.s3.bucket_name
}


output "s3_bucket_arn" {

  description = "Production S3 bucket ARN"

  value = module.s3.bucket_arn
}