# ============================================================
# nearBy - EKS CLUSTER
# ============================================================


# ============================================================
# EKS CLUSTER
# ============================================================

resource "aws_eks_cluster" "this" {

  name = "${var.project_name}-${var.environment}-eks"

  version = var.kubernetes_version

  role_arn = var.eks_cluster_role_arn


  # ----------------------------------------------------------
  # VPC CONFIGURATION
  # ----------------------------------------------------------

  vpc_config {

    # EKS will run in private subnets
    subnet_ids = var.private_subnet_ids

    # Security group for EKS
    security_group_ids = [
      var.eks_security_group_id
    ]

    # API endpoint configuration
    endpoint_private_access = true

    endpoint_public_access = true
  }


  tags = {

    Name        = "${var.project_name}-${var.environment}-eks"

    Project     = var.project_name

    Environment = var.environment

    ManagedBy   = "Terraform"
  }
}


# ============================================================
# EKS MANAGED NODE GROUP
# ============================================================

resource "aws_eks_node_group" "this" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${var.project_name}-${var.environment}-nodes"

  node_role_arn = var.eks_node_role_arn


  # ----------------------------------------------------------
  # PRIVATE SUBNETS
  # ----------------------------------------------------------

  subnet_ids = var.private_subnet_ids


  # ----------------------------------------------------------
  # INSTANCE TYPE
  # ----------------------------------------------------------

  instance_types = var.node_instance_types


  # ----------------------------------------------------------
  # SCALING
  # ----------------------------------------------------------

  scaling_config {

    desired_size = var.desired_nodes

    min_size = var.min_nodes

    max_size = var.max_nodes
  }


  # ----------------------------------------------------------
  # UPDATE CONFIGURATION
  # ----------------------------------------------------------

  update_config {

    max_unavailable = 1
  }


  # ----------------------------------------------------------
  # TAGS
  # ----------------------------------------------------------

  tags = {

    Name        = "${var.project_name}-${var.environment}-eks-node"

    Project     = var.project_name

    Environment = var.environment

    ManagedBy   = "Terraform"
  }


  # Make sure cluster exists first
  depends_on = [
    aws_eks_cluster.this
  ]
}