# ============================================================
# SUMO - VPC VARIABLES
# ============================================================


# ------------------------------------------------------------
# PROJECT NAME
# ------------------------------------------------------------

variable "project_name" {

  description = "Project name"

  type = string

  default = "sumo"
}


# ------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------

variable "environment" {

  description = "Environment name"

  type = string

  default = "staging"
}


# ------------------------------------------------------------
# VPC CIDR
# ------------------------------------------------------------

variable "vpc_cidr" {

  description = "CIDR block for VPC"

  type = string

  default = "10.0.0.0/16"
}


# ------------------------------------------------------------
# AWS AVAILABILITY ZONES
# ------------------------------------------------------------

variable "availability_zones" {

  description = "Availability zones"

  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}


# ------------------------------------------------------------
# PUBLIC SUBNET CIDRs
# ------------------------------------------------------------

variable "public_subnet_cidrs" {

  description = "CIDR blocks for public subnets"

  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}


# ------------------------------------------------------------
# PRIVATE SUBNET CIDRs
# ------------------------------------------------------------

variable "private_subnet_cidrs" {

  description = "CIDR blocks for private subnets"

  type = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}