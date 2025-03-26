# Configure AWS Provider
provider "aws" {
  region = var.aws_region
}

resource "random_id" "unique_key" {
    byte_length = 6
}

# Create S3 bucket for storing Terraform state
resource "aws_s3_bucket" "state_bucket" {
  # use the specified bucket name, but append a unique suffix to keep it globally unique
  bucket = "${var.project_state_name}-${random_id.unique_key.hex}"

  # Prevent accidental deletion of this bucket
  lifecycle {
    prevent_destroy = true
  }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket_encryption" {
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "state_bucket_public_access" {
  bucket                  = aws_s3_bucket.state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "state_locks" {
  name         = "${var.project_state_name}-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}