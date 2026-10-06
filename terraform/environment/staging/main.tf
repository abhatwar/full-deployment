# ============================================================
# nearBy STAGING INFRASTRUCTURE
# ============================================================


# ------------------------------------------------------------
# VPC
# ------------------------------------------------------------

module "vpc" {

  source = "../../modules/vpc"

  project_name = var.project_name

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs
}

# ============================================================
# SECURITY GROUPS
# ============================================================

module "security_groups" {

  source = "../../modules/security-groups"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.vpc.vpc_id
}

# ============================================================
# IAM
# ============================================================

module "iam" {

  source = "../../modules/iam"

  project_name = var.project_name

  environment = var.environment
}

# ============================================================
# ECR
# ============================================================

module "ecr" {

  source = "../../modules/ecr"

  project_name = var.project_name

  environment = var.environment
}


# ============================================================
# EKS
# ============================================================

module "eks" {

  source = "../../modules/eks"

  project_name = var.project_name

  environment = var.environment

  # Kubernetes version
  kubernetes_version = "1.33"

  # VPC
  vpc_id = module.vpc.vpc_id

  # Private subnets
  private_subnet_ids = module.vpc.private_subnet_ids

  # IAM
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn

  eks_node_role_arn = module.iam.eks_node_role_arn

  # Security group
  eks_security_group_id = module.security_groups.eks_security_group_id

  # Staging node configuration
  node_instance_types = [
    "t3.medium"
  ]

  desired_nodes = 1

  min_nodes = 1

  max_nodes = 2
}

# ============================================================
# S3
# ============================================================

module "s3" {

  source = "../../modules/s3"

  project_name = var.project_name

  environment = var.environment
}