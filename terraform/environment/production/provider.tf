# ============================================================
# nearBy PRODUCTION - TERRAFORM PROVIDER
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

# Configure AWS credentials outside Terraform using an IAM role, AWS profile, or environment variables.
provider "aws" {

  # AWS region comes from terraform.tfvars
  region = var.aws_region

  # Default tags applied to AWS resources
  default_tags {

    tags = {

      Project     = "nearBy"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}