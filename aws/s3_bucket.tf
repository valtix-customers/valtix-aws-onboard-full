# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# AWS Valtix S3 Bucket
# Used for inventory discovery (Asset, VPC Flow and DNS Query Logs)
resource "aws_s3_bucket" "valtix_s3_bucket" {
  bucket        = var.aws_valtix_s3_bucket
  force_destroy = true
}

# AWS Valtix S3 Bucket Encryption
# Defines the encryption policy for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "valtix_s3_bucket_encryption" {
  bucket = aws_s3_bucket.valtix_s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# AWS Valtix S3 Bucket Lifecycl Configuration
# Defines the policy for how long information placed into the S3 bucket will
# remain before deleted
resource "aws_s3_bucket_lifecycle_configuration" "valtix_s3_bucket_lifecycle" {
  bucket   = aws_s3_bucket.valtix_s3_bucket.id
  rule {
    id     = "Delete Objects after ${var.aws_valtix_s3_object_duration} days"
    status = "Enabled"
    expiration {
      days = var.aws_valtix_s3_object_duration
    }
  }
}

# AWS Valtix S3 Bucket Public Access Policy
# Defines the policy on whether the S3 bucket is exposed externally
resource "aws_s3_bucket_public_access_block" "valtix_s3_bucket_public_access" {
  bucket                  = aws_s3_bucket.valtix_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# AWS Valtix S3 Bucket Policy
# Sets the various policies (defined above) to the S3 bucket
resource "aws_s3_bucket_policy" "valtix_s3_bucket_policy" {
  bucket   = aws_s3_bucket.valtix_s3_bucket.id
  depends_on = [
    aws_s3_bucket_public_access_block.valtix_s3_bucket_public_access
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "valtix-bucket-policy"
    Statement = [
      {
        Action   = "s3:GetBucketAcl",
        Effect   = "Allow",
        Resource = aws_s3_bucket.valtix_s3_bucket.arn,
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      },
      {
        Action   = "s3:PutObject",
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.valtix_s3_bucket.arn}/AWSLogs/${var.aws_account_number}/*",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Action   = "s3:GetBucketAcl",
        Effect   = "Allow",
        Resource = aws_s3_bucket.valtix_s3_bucket.arn,
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      },
      {
        Action   = "s3:PutObject",
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.valtix_s3_bucket.arn}/AWSLogs/${var.aws_account_number}/*",
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        },
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# AWS valtix S3 Bucket Notification
# Defines how the AWS S3 bucket notifications policy for when new data is
# placed in the bucket 
resource "aws_s3_bucket_notification" "valtix_s3_bucket_notification" {
  bucket   = aws_s3_bucket.valtix_s3_bucket.id
  queue {
    queue_arn = "arn:aws:sqs:${var.aws_account_region}:${var.aws_valtix_controller_account}:inventory_logs_queue_${var.aws_valtix_deployment_name}_${var.aws_account_region}"
    events    = ["s3:ObjectCreated:*"]
  }
  # to make the destroy go in sequence, otherwise you get "conflicting operation" errors
  depends_on = [
    aws_s3_bucket_policy.valtix_s3_bucket_policy
  ]
}