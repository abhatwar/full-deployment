# ============================================================
# nearBy - S3 BUCKET
# ============================================================


# ============================================================
# S3 BUCKET
# ============================================================

resource "aws_s3_bucket" "this" {

  # Bucket names must be globally unique.
  #
  # For real project use something unique,
  # for example:
  #
  # nearby-production-assets-123456

  bucket = "${var.project_name}-${var.environment}-assets"


  tags = {

    Name = "${var.project_name}-${var.environment}-assets"

    Project = var.project_name

    Environment = var.environment

    ManagedBy = "Terraform"
  }
}


# ============================================================
# BLOCK PUBLIC ACCESS
# ============================================================

resource "aws_s3_bucket_public_access_block" "this" {

  bucket = aws_s3_bucket.this.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true
}


# ============================================================
# VERSIONING
# ============================================================

resource "aws_s3_bucket_versioning" "this" {

  bucket = aws_s3_bucket.this.id

  versioning_configuration {

    status = "Enabled"
  }
}


# ============================================================
# SERVER-SIDE ENCRYPTION
# ============================================================

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

  bucket = aws_s3_bucket.this.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"
    }
  }
}