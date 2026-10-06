# ============================================================
# nearBy - VPC OUTPUTS
# ============================================================


# ------------------------------------------------------------
# VPC ID
# ------------------------------------------------------------

output "vpc_id" {

  description = "VPC ID"

  value = aws_vpc.this.id
}


# ------------------------------------------------------------
# VPC CIDR
# ------------------------------------------------------------

output "vpc_cidr" {

  description = "VPC CIDR"

  value = aws_vpc.this.cidr_block
}


# ------------------------------------------------------------
# PUBLIC SUBNET IDs
# ------------------------------------------------------------

output "public_subnet_ids" {

  description = "Public subnet IDs"

  value = aws_subnet.public[*].id
}


# ------------------------------------------------------------
# PRIVATE SUBNET IDs
# ------------------------------------------------------------

output "private_subnet_ids" {

  description = "Private subnet IDs"

  value = aws_subnet.private[*].id
}


# ------------------------------------------------------------
# INTERNET GATEWAY
# ------------------------------------------------------------

output "internet_gateway_id" {

  description = "Internet Gateway ID"

  value = aws_internet_gateway.this.id
}


# ------------------------------------------------------------
# NAT GATEWAY
# ------------------------------------------------------------

output "nat_gateway_id" {

  description = "NAT Gateway ID"

  value = aws_nat_gateway.this.id
}