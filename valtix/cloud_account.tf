# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# Sleep / Wait for the Valtix Controller Role to finish being created
resource "time_sleep" "wait_for_controller_account" {
  depends_on = [
    var.aws_valtix_controller_role_arn
  ]
  create_duration = "15s"
}

# Valtix AWS Cloud Account Onboard
# Onboard the prepared AWS Account into Valtix
resource "valtix_cloud_account" "aws_cloud_account" {
  depends_on = [
    time_sleep.wait_for_controller_account
  ]
  name                     = var.valtix_aws_account_name
  csp_type                 = "AWS"
  aws_credentials_type     = "AWS_IAM_ROLE"
  aws_iam_role             = var.aws_valtix_controller_role_arn
  aws_account_number       = var.aws_account_number
  aws_iam_role_external_id = valtix_external_id.iam_external_id.external_id
  aws_inventory_iam_role   = var.aws_valtix_inventory_role_arn
  inventory_monitoring {
    regions = var.valtix_aws_inventory_regions
  }
}