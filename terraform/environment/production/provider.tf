# ============================================================
# SUMO PRODUCTION - TERRAFORM PROVIDER
# ============================================================

terraform {

  # Minimum Terraform version
  required_version = ">= 1.6.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


# ============================================================
# AWS PROVIDER
# ============================================================

provider "aws" {

  # AWS region comes from terraform.tfvars
  region = var.aws_region

  # Default tags applied to AWS resources
  default_tags {

    tags = {

      Project     = "SUMO"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}