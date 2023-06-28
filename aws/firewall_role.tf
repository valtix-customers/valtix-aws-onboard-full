# Valtix Terraform Documentation
  # https://registry.terraform.io/providers/valtix-security/valtix/latest/docs
# AWS Terraform Documentation
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# AWS IAM Role for the Valtix Gateway
# Used to allow the Valtix Gateway to communicate with the AWS Account
resource "aws_iam_role" "valtix_firewall_role" {
  name = var.aws_valtix_firewall_role
  tags = {
    Name   = var.aws_valtix_firewall_role
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow"
      }
    ]
  })
}

# AWS IAM Role Policy for the Valtix Gateway
# The IAM Role policy that defines the permissions for the Valtix Gateway
resource "aws_iam_role_policy" "valtix_firewall_policy" {
  name = var.aws_valtix_firewall_role
  role = aws_iam_role.valtix_firewall_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::*/*"
      },
      {
        Action = [
          "kms:Decrypt"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# for instances to use the role, an instance profile must be created and
# instance profile name used on the instance's iam role
# however on the firewall iam role text box you can provide the role
# name or the arn of either the role or the instance profile
resource "aws_iam_instance_profile" "valtix_fw_role" {
  name = var.aws_valtix_firewall_role
  role = aws_iam_role.valtix_firewall_role.name
}