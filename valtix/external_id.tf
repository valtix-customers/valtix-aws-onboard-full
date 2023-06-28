# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# Valtix External ID
# Used in the AWS IAM Role for the Valtix Controller to define a trust
# relationship between the AWS Account and the Valtix Controller
resource "valtix_external_id" "iam_external_id" {
  name = "ext_id1"
}