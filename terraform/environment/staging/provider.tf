terraform {

  required_version = ">= 1.6.0"

  required_providers {

    aws = {

      source = "hashicorp/aws"

      version = "~> 6.0"
    }
  }
}


# Configure AWS credentials outside Terraform using an IAM role, AWS profile, or environment variables.
provider "aws" {

  region = var.aws_region

  default_tags {

    tags = {

      Project = "nearBy"

      Environment = var.environment

      ManagedBy = "Terraform"
    }
  }
}