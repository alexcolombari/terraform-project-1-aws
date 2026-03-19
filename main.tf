resource "random_pet" "random_name" {
  length = 2
}

resource "aws_s3_bucket" "s3_main" {
  bucket = "${random_pet.random_name.id}-s3-bucket"

  tags = {
    Name        = "Main Bucket"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.s3_main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}