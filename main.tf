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

# Defining user policy
resource "aws_iam_policy" "bucket_access" {
  name        = "BucketAccess"
  description = "Allows to manage buckets objects"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListBucket"]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.s3_main.arn]
      },
      {
        Action   = ["s3:GetObject", "s3:PutObject"]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.s3_main.arn}/*"]
      }
    ]
  })
}

# Attach policy to users
resource "aws_iam_user_policy_attachment" "s3_users_access" {
  for_each   = toset(var.iam_users)
  user       = aws_iam_user.users[each.key].name
  policy_arn = aws_iam_policy.bucket_access.arn
}

# S3 Versioning
resource "aws_s3_bucket_versioning" "main_bucket_versioning" {
  bucket = aws_s3_bucket.s3_main.id
  versioning_configuration {
    status = "Enabled"
  }
}