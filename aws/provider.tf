# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# Specify the AWS Terraform Provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}