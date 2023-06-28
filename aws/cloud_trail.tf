# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# AWS Valtix CloudTrail
# This resource is used to make Valtix Controller aware of when new content
# is avaialble in the S3 bucket
resource "aws_cloudtrail" "valtix_cloudtrail" {
  name                          = var.aws_valtix_cloudtrail
  s3_bucket_name                = aws_s3_bucket.valtix_s3_bucket.id
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_logging                = true
  depends_on = [
    aws_s3_bucket_policy.valtix_s3_bucket_policy
  ]
  tags = {
    Name   = var.aws_valtix_cloudtrail
  }
}