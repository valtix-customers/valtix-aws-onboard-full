# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# Specify the Valtix Terraform Provider
terraform {
  required_providers {
     valtix = {
      source  = "valtix-security/valtix"
    }
  }
}