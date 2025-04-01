terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.92.0"
    }
  }
  # values pulled from ./env/<env_name>/backend.tfvars.tf, and
  # explicitly passed in via the cli or environment vars
  backend "s3" {
  }
}
