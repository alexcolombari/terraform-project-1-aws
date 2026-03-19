# Resource Random Pet to generate random name for S3 Bucket
resource "random_pet" "random_name" {
  length = 2
}

# Create S3 Bucket
resource "aws_s3_bucket" "s3_main" {
  bucket = "${random_pet.random_name.id}-bucket"

  tags = {
    Name        = "Main Bucket"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Blocking public access to Bucket
resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.s3_main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.s3_main]
}

# Configure Website
resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.s3_main.id

  index_document {
    suffix = "index.html"
  }
}

# Create the index file automatically
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.s3_main.id
  key          = "index.html"
  content      = "<h1>Terraform Project - LocalStack</h1>"
  content_type = "text/html"
}

# Create IAM Users
resource "aws_iam_user" "users" {
  for_each = toset(var.iam_users)
  name     = each.key
}