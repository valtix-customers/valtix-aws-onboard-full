# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# AWS Account Number
variable "aws_account_number" {
  description = "Number of the AWS Account"
  default     = ""
  type        = string
}

# AWS Valtix Controller IAM Role ARN
variable "aws_valtix_controller_role_arn" {
  description = "AWS IAM ARN of the Valtix Controller Role"
  default     = ""
  type        = string
}

# AWS Valtix Inventory IAM Role ARN
variable "aws_valtix_inventory_role_arn" {
  description = "AWS IAM ARN of the Valtix Inventory Role"
  default     = ""
  type        = string
}

# Valtix AWS Account Name
variable "valtix_aws_account_name" {
  description = "Valtix Account name given to the onboarded AWS account"
  default     = ""
  type        = string
}

# Valtix AWS Inventory Regions
variable "valtix_aws_inventory_regions" {
  description = "Regions that Valtix Controller can monitor and update the inventory for dynamic security policies: us-east-1, us-east-2"
  default     = []
  type        = list(string)
}