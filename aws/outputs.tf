# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# AWS Valtix Controller Role ARN
# Used by the Valtix Cloud Account onbarding to create a relationship between
# the Valtix Controller Account and the AWS Account for orchestration
output "valtix_controller_role_arn" {
  value = aws_iam_role.valtix_controller_role.arn
}

# AWS Valtix Inventory Role ARN
# Use by the Valtix Controller onboarding to create a relationship between
# the Valtix Controller Account and the AWS Account for inventory discovery
output "valtix_inventory_role_arn" {
  value = aws_iam_role.valtix_inventory_role.arn
}