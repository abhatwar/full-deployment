# ============================================================
# nearBy - ECR REPOSITORY
# ============================================================


# ============================================================
# ECR REPOSITORY
# ============================================================

resource "aws_ecr_repository" "this" {

  # Repository name
  #
  # Example:
  # nearby-staging
  # nearby-production
  name = "${var.project_name}-${var.environment}"


  # ----------------------------------------------------------
  # Image Tag Mutability
  # ----------------------------------------------------------
  #
  # IMMUTABLE means:
  #
  # Once an image tag is pushed,
  # that tag cannot be overwritten.
  #
  # This is useful for production deployments.
  #

  image_tag_mutability = "IMMUTABLE"


  # ----------------------------------------------------------
  # Scan Docker images when pushed
  # ----------------------------------------------------------

  image_scanning_configuration {

    scan_on_push = true
  }


  # ----------------------------------------------------------
  # Encryption
  # ----------------------------------------------------------

  encryption_configuration {

    encryption_type = "AES256"
  }


  # ----------------------------------------------------------
  # Tags
  # ----------------------------------------------------------

  tags = {

    Name        = "${var.project_name}-${var.environment}-ecr"

    Project     = var.project_name

    Environment = var.environment

    ManagedBy   = "Terraform"
  }
}