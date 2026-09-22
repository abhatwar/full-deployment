# ============================================================
# SUMO - SECURITY GROUPS
# ============================================================


# ============================================================
# ALB SECURITY GROUP
# ============================================================

resource "aws_security_group" "alb" {

  name = "${var.project_name}-${var.environment}-alb-sg"

  description = "Security group for SUMO Application Load Balancer"

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ------------------------------------------------------------
# ALB HTTP
# ------------------------------------------------------------

resource "aws_vpc_security_group_ingress_rule" "alb_http" {

  security_group_id = aws_security_group.alb.id

  # HTTP
  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"

  # Allow HTTP from internet
  cidr_ipv4 = "0.0.0.0/0"
}


# ------------------------------------------------------------
# ALB HTTPS
# ------------------------------------------------------------

resource "aws_vpc_security_group_ingress_rule" "alb_https" {

  security_group_id = aws_security_group.alb.id

  # HTTPS
  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  # Allow HTTPS from internet
  cidr_ipv4 = "0.0.0.0/0"
}


# ------------------------------------------------------------
# ALB OUTBOUND
# ------------------------------------------------------------

resource "aws_vpc_security_group_egress_rule" "alb_all" {

  security_group_id = aws_security_group.alb.id

  ip_protocol = "-1"

  # Allow ALB to communicate with backend
  cidr_ipv4 = "0.0.0.0/0"
}


# ============================================================
# EKS SECURITY GROUP
# ============================================================

resource "aws_security_group" "eks" {

  name = "${var.project_name}-${var.environment}-eks-sg"

  description = "Security group for SUMO EKS workloads"

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-eks-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ------------------------------------------------------------
# EKS FROM ALB
# ------------------------------------------------------------

resource "aws_vpc_security_group_ingress_rule" "eks_from_alb" {

  security_group_id = aws_security_group.eks.id

  # Backend application port
  from_port = 7050
  to_port   = 7050

  ip_protocol = "tcp"

  # Only ALB can access backend
  referenced_security_group_id = aws_security_group.alb.id
}


# ------------------------------------------------------------
# EKS INTERNAL COMMUNICATION
# ------------------------------------------------------------

resource "aws_vpc_security_group_ingress_rule" "eks_internal" {

  security_group_id = aws_security_group.eks.id

  # Allow all traffic between EKS resources
  from_port = -1
  to_port   = -1

  ip_protocol = "-1"

  referenced_security_group_id = aws_security_group.eks.id
}


# ------------------------------------------------------------
# EKS OUTBOUND
# ------------------------------------------------------------

resource "aws_vpc_security_group_egress_rule" "eks_all" {

  security_group_id = aws_security_group.eks.id

  ip_protocol = "-1"

  # EKS nodes need outbound access through NAT
  cidr_ipv4 = "0.0.0.0/0"
}


# ============================================================
# RDS SECURITY GROUP
# ============================================================

resource "aws_security_group" "rds" {

  name = "${var.project_name}-${var.environment}-rds-sg"

  description = "Security group for SUMO database"

  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ------------------------------------------------------------
# RDS FROM EKS
# ------------------------------------------------------------

resource "aws_vpc_security_group_ingress_rule" "rds_from_eks" {

  security_group_id = aws_security_group.rds.id

  # Example SQL Server port
  from_port = 1433
  to_port   = 1433

  ip_protocol = "tcp"

  # Only EKS can access database
  referenced_security_group_id = aws_security_group.eks.id
}


# ------------------------------------------------------------
# RDS OUTBOUND
# ------------------------------------------------------------

resource "aws_vpc_security_group_egress_rule" "rds_all" {

  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}