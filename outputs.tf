output "s3" {
  description = "S3 Output"
  value       = aws_s3_bucket.s3_main.id
}

output "users" {
  description = "IAM Users Output"
  value       = aws_iam_user.users[*]
}

output "site" {
  description = "Website Output. Access website: "
  value       = "http://${aws_s3_bucket.s3_main.id}.localhost:4566/index.html"
}