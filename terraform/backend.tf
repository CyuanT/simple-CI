resource "aws_s3_bucket" "ce7-ty-ci" {
  bucket        = "ce7-ty-simple-ECS"
  force_destroy = true

  lifecycle_rule {
    enabled = true
    id      = "expire"
    prefix  = "logs/"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    expiration {
      days = 90
    }
  }

  #checkov:skip=CKV2_AWS_6:Ensure that S3 bucket has a Public Access block
  #checkov:skip=CKV_AWS_144:Ensure that S3 bucket has cross-region replication enabled
  #checkov:skip=CKV_AWS_145:Ensure that S3 buckets are encrypted with KMS by default
  #checkov:skip=CKV_AWS_21:Ensure all data stored in the S3 bucket have versioning enabled

}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.ce7-ty-ci.id

  target_bucket = aws_s3_bucket.ce7-ty-ci.id
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

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.ce7-ty-ci.id

  rule {
    id = "rule-1"
    filter {

    }
    status = "Enabled"
  }
  #checkov:skip=CKV_AWS_300:Ensure S3 lifecycle configuration sets period for aborting failed uploads
}


