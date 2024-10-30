terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_s3_bucket" "ce7-ty-ci" {
  bucket        = "ce7-ty-simple-ci"
  force_destroy = true

  lifecycle_rule {
    enabled = true
    id     = "expire"
    prefix = "logs/"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    expiration {
      days = 90
    }
  }

  versioning_configuration {
    status = "Enabled"
  }
  }

  #checkov:skip=CKV2_AWS_6:Ensure that S3 bucket has a Public Access block
  #checkov:skip=CKV_AWS_144:Ensure that S3 bucket has cross-region replication enabled
  #checkov:skip=CKV_AWS_145:Ensure that S3 buckets are encrypted with KMS by default

}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.ce7-ty-ci.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

resource "aws_sns_topic" "bucket_notifications" {
  name = "ce7-ty-ci-notifications"
  #checkov:skip=CKV_AWS_26:Ensure all data stored in the SNS topic is encrypted
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.ce7-ty-ci.id

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.ce7-ty-ci.id

  versioning_configuration {
    status = "Enabled"
  }
}


