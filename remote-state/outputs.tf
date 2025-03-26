output "S3_bucket_name" {
  value = aws_s3_bucket.state_bucket.bucket
  description = "The name of the S3 bucket created for storing Terraform state"
}

output "lock_table_name" {
  value = aws_dynamodb_table.state_locks.name
  description = "The name of the DynamoDB table created for storing Terraform locks"
}
