# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# Specify the Terraform Providers
  # Note: No Variables can be used within the Terraform block
terraform {
  required_providers {
    valtix = {
      source  = "valtix-security/valtix"
      version = "22.5.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Set the AWS Terraform Provider Settings
provider "aws" {
  profile = var.aws_account_name
  region  = var.aws_account_region
}

# Set the Valtix Terraform Provider Settings
provider "valtix" {
  acctname     = var.valtix_aws_account_name
  api_key_file = file(var.valtix_api_key_file)
}