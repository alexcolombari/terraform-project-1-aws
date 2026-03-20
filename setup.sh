#!/bin/bash
# Main script to run Docker, initialize Terraform and apply the infrastructure
docker run -d -p 4566:4566 localstack/localstack
sleep 10
terraform init
terraform apply -auto-approve