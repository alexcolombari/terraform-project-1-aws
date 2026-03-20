#!/bin/bashrc
# Main script to run Docker, initialize Terraform and apply the infrastructure~
echo "Starting LocalStack..."
docker run -d --rm -p 4566:4566 -p 4510-4559:4510-4559 --name localstack_terraform localstack/localstack

echo "Waiting..."
sleep 15

echo "Init Terraform..."
terraform init

echo "Applying Infrastructure..."
terraform apply -auto-approve

echo "Environment ready!"