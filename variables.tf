variable "environment" {
  description = "Default Environment"
  type        = string
  default     = "Dev-Local"
}

variable "region" {
  description = "Default AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "endpoints" {
  description = "Default endpoints address"
  type        = string
  default     = "http://localhost:4566"
}

variable "iam_users" {
  description = "Default Users"
  type        = list(string)
  default     = ["alex", "gabriela", "joao"]
}