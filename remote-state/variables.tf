variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "Default AWS region"
}

variable "project_state_name" {
  type = string
  default = "terraform-state"
  description = "Default name for storing Terraform state, used for S3 bucket and DynamoDB table"
}
