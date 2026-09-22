# ============================================================
# SUMO - VPC MODULE
# ============================================================

# ------------------------------------------------------------
# VPC
# ------------------------------------------------------------

resource "aws_vpc" "this" {

  # Main VPC CIDR
  cidr_block = var.vpc_cidr

  # Enable DNS support
  enable_dns_support = true

  # Enable DNS hostnames
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


# ============================================================
# INTERNET GATEWAY
# ============================================================

resource "aws_internet_gateway" "this" {

  # Attach Internet Gateway to VPC
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# PUBLIC SUBNETS
# ============================================================

resource "aws_subnet" "public" {

  count = length(var.availability_zones)

  # VPC
  vpc_id = aws_vpc.this.id

  # Example:
  # 10.0.1.0/24
  # 10.0.2.0/24
  cidr_block = var.public_subnet_cidrs[count.index]

  # Different AZ for high availability
  availability_zone = var.availability_zones[count.index]

  # Public IP automatically assigned
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-${count.index + 1}"

    Project     = var.project_name
    Environment = var.environment

    # Required/recommended for AWS Load Balancer Controller
    "kubernetes.io/role/elb" = "1"
  }
}


# ============================================================
# PRIVATE SUBNETS
# ============================================================

resource "aws_subnet" "private" {

  count = length(var.availability_zones)

  # VPC
  vpc_id = aws_vpc.this.id

  # Example:
  # 10.0.11.0/24
  # 10.0.12.0/24
  cidr_block = var.private_subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  # Do NOT automatically assign public IP
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-${count.index + 1}"

    Project     = var.project_name
    Environment = var.environment

    # Required/recommended for EKS load balancing
    "kubernetes.io/role/internal-elb" = "1"
  }
}


# ============================================================
# ELASTIC IP FOR NAT GATEWAY
# ============================================================

resource "aws_eip" "nat" {

  # EIP is used by NAT Gateway
  domain = "vpc"

  tags = {
    Name        = "${var.project_name}-${var.environment}-nat-eip"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# NAT GATEWAY
# ============================================================

resource "aws_nat_gateway" "this" {

  # NAT Gateway gets public IP from EIP
  allocation_id = aws_eip.nat.id

  # NAT Gateway must be inside public subnet
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name        = "${var.project_name}-${var.environment}-nat"
    Project     = var.project_name
    Environment = var.environment
  }

  # Make sure Internet Gateway exists first
  depends_on = [
    aws_internet_gateway.this
  ]
}


# ============================================================
# PUBLIC ROUTE TABLE
# ============================================================

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# PUBLIC ROUTE
# ============================================================

resource "aws_route" "public_internet" {

  route_table_id = aws_route_table.public.id

  # Internet traffic
  destination_cidr_block = "0.0.0.0/0"

  # Send traffic to Internet Gateway
  gateway_id = aws_internet_gateway.this.id
}


# ============================================================
# PUBLIC ROUTE TABLE ASSOCIATION
# ============================================================

resource "aws_route_table_association" "public" {

  count = length(var.availability_zones)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}


# ============================================================
# PRIVATE ROUTE TABLE
# ============================================================

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-rt"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# PRIVATE ROUTE
# ============================================================

resource "aws_route" "private_internet" {

  route_table_id = aws_route_table.private.id

  # Internet traffic
  destination_cidr_block = "0.0.0.0/0"

  # Private subnet reaches internet through NAT
  nat_gateway_id = aws_nat_gateway.this.id
}


# ============================================================
# PRIVATE ROUTE TABLE ASSOCIATION
# ============================================================

resource "aws_route_table_association" "private" {

  count = length(var.availability_zones)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private.id
}