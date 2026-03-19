terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.37"
    }
  }

  required_version = "~> 1.14"
}