# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# Valtix External ID Output
# Outputs the generated Valtix External ID to be used in the AWS IAM Role Policy
# for the Valtix Controller Role
output "valtix_external_id" {
  value = valtix_external_id.iam_external_id.external_id
}