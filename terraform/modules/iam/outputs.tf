# ============================================================
# nearBy - IAM MODULE
# ============================================================


# ============================================================
# EKS CLUSTER IAM ROLE
# ============================================================

resource "aws_iam_role" "eks_cluster" {

  name = "${var.project_name}-${var.environment}-eks-cluster-role"

  # ----------------------------------------------------------
  # Trust policy
  # Allows EKS service to assume this role
  # ----------------------------------------------------------

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }

    ]
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# EKS CLUSTER POLICY
# ============================================================

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {

  role = aws_iam_role.eks_cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


# ============================================================
# EKS NODE IAM ROLE
# ============================================================

resource "aws_iam_role" "eks_node" {

  name = "${var.project_name}-${var.environment}-eks-node-role"

  # ----------------------------------------------------------
  # Trust policy
  # Allows EC2 instances to assume this role
  # ----------------------------------------------------------

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }

    ]
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# EKS WORKER NODE POLICIES
# ============================================================


# ------------------------------------------------------------
# EKS Worker Node Policy
# ------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {

  role = aws_iam_role.eks_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}


# ------------------------------------------------------------
# ECR Access
# ------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "ecr_read_only" {

  role = aws_iam_role.eks_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# ------------------------------------------------------------
# CNI Policy
# ------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {

  role = aws_iam_role.eks_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}