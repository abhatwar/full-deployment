output "vpc_id" {

  description = "nearBy VPC ID"

  value = module.vpc.vpc_id
}


output "public_subnet_ids" {

  description = "nearBy public subnet IDs"

  value = module.vpc.public_subnet_ids
}


output "private_subnet_ids" {

  description = "nearBy private subnet IDs"

  value = module.vpc.private_subnet_ids
}


output "nat_gateway_id" {

  description = "nearBy NAT Gateway ID"

  value = module.vpc.nat_gateway_id
}

output "alb_security_group_id" {

  description = "Staging ALB security group"

  value = module.security_groups.alb_security_group_id
}


output "eks_security_group_id" {

  description = "Staging EKS security group"

  value = module.security_groups.eks_security_group_id
}


output "rds_security_group_id" {

  description = "Staging RDS security group"

  value = module.security_groups.rds_security_group_id
}


# ============================================================
# IAM OUTPUTS
# ============================================================

output "eks_cluster_role_arn" {

  description = "Staging EKS cluster IAM role ARN"

  value = module.iam.eks_cluster_role_arn
}


output "eks_node_role_arn" {

  description = "Staging EKS node IAM role ARN"

  value = module.iam.eks_node_role_arn
}


# ============================================================
# ECR OUTPUTS
# ============================================================

output "ecr_repository_url" {

  description = "Staging ECR repository URL"

  value = module.ecr.repository_url
}


output "ecr_repository_arn" {

  description = "Staging ECR repository ARN"

  value = module.ecr.repository_arn
}


output "ecr_repository_name" {

  description = "Staging ECR repository name"

  value = module.ecr.repository_name
}

# ============================================================
# EKS OUTPUTS
# ============================================================

output "eks_cluster_name" {

  description = "Staging EKS cluster name"

  value = module.eks.cluster_name
}


output "eks_cluster_endpoint" {

  description = "Staging EKS cluster endpoint"

  value = module.eks.cluster_endpoint
}


output "eks_node_group_name" {

  description = "Staging EKS node group"

  value = module.eks.node_group_name
}

# ============================================================
# S3 OUTPUTS
# ============================================================

output "s3_bucket_name" {

  description = "Staging S3 bucket"

  value = module.s3.bucket_name
}


output "s3_bucket_arn" {

  description = "Staging S3 bucket ARN"

  value = module.s3.bucket_arn
}