# ============================================================
# SUMO PRODUCTION - VARIABLES
# ============================================================


# ------------------------------------------------------------
# AWS REGION
# ------------------------------------------------------------

variable "aws_region" {

  description = "AWS region where production infrastructure will be created"

  type = string

  default = "ap-south-1"
}


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

  description = "Deployment environment"

  type = string

  default = "production"
}


# ------------------------------------------------------------
# VPC CIDR
# ------------------------------------------------------------

variable "vpc_cidr" {

  description = "Production VPC CIDR"

  type = string

  default = "10.1.0.0/16"
}


# ------------------------------------------------------------
# AVAILABILITY ZONES
# ------------------------------------------------------------

variable "availability_zones" {

  description = "AWS availability zones"

  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}


# ------------------------------------------------------------
# PUBLIC SUBNETS
# ------------------------------------------------------------

variable "public_subnet_cidrs" {

  description = "CIDR blocks for public subnets"

  type = list(string)

  default = [
    "10.1.1.0/24",
    "10.1.2.0/24"
  ]
}


# ------------------------------------------------------------
# PRIVATE SUBNETS
# ------------------------------------------------------------

variable "private_subnet_cidrs" {

  description = "CIDR blocks for private subnets"

  type = list(string)

  default = [
    "10.1.11.0/24",
    "10.1.12.0/24"
  ]
}