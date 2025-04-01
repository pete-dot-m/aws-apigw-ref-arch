# This file contains the variable definitions for the Terraform configuration
# per-environment overrides should be placed in ./env/<environment>/variables.tf

variable "region" {
  description = "The AWS region to provision resources into"
  type        = string
  default     = "us-east-1"
}

variable "environment_root" {
  description = "The root name of the environment being created (e.g., prod, non-prod, staging)"
  type        = string
  default     = "non-prod"
}

variable "vpc_cidr" {
  description = "CIDR block for AWS VPC"
  type = string
  default = "10.1.100.0/22"
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for subnets in the VPC"
  type = list(string)
  default = [
    "10.1.100.0/24",
    "10.1.101.0/24",
    "10.1.102.0/24"
  ]
}
