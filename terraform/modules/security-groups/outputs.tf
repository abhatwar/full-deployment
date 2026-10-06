# ============================================================
# nearBy - SECURITY GROUP OUTPUTS
# ============================================================


# ============================================================
# ALB SECURITY GROUP
# ============================================================

output "alb_security_group_id" {

  description = "ALB security group ID"

  value = aws_security_group.alb.id
}


# ============================================================
# EKS SECURITY GROUP
# ============================================================

output "eks_security_group_id" {

  description = "EKS security group ID"

  value = aws_security_group.eks.id
}


# ============================================================
# RDS SECURITY GROUP
# ============================================================

output "rds_security_group_id" {

  description = "RDS security group ID"

  value = aws_security_group.rds.id
}