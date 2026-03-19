output "s3" {
  description = "S3 Output"
  value       = aws_s3_bucket.s3_main.id
}