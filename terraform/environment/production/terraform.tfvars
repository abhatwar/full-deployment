# ============================================================
# SUMO PRODUCTION TERRAFORM VARIABLES
# ============================================================

# AWS region
aws_region = "ap-south-1"

# Project name
project_name = "sumo"

# Environment
environment = "production"

# Production VPC
vpc_cidr = "10.1.0.0/16"

# Availability Zones
availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

# Public subnets
public_subnet_cidrs = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]

# Private subnets
private_subnet_cidrs = [
  "10.1.11.0/24",
  "10.1.12.0/24"
]