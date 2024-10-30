resource "aws_s3_bucket" "ci-example" {
    bucket = "ce7-ty-terraform-ci-bucket"

    versioning_configuration {
    status = "Enabled"
  }
    lifecycle_rule {
    id      = "expire"
    status  = "Enabled"
    prefix  = "logs/"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    expiration {
      days = 90
    }
  }
}

resource "aws_sns_topic" "bucket_notifications" {
  name = "ce7-ty-ci-notifications"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.ci-example.id

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.ci-example.id
  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_versioning" "east" {
  bucket = aws_s3_bucket.ci-example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "west" {
  provider = aws.west
  bucket   = "ce7-ty-ci-bucket-west"
}

resource "aws_s3_bucket_versioning" "west" {
  provider = aws.west

  bucket = aws_s3_bucket.west.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "east_to_west" {
  depends_on = [aws_s3_bucket_versioning.east]
  role   = aws_iam_role.east_replication.arn
  bucket = aws_s3_bucket.east.id

  rule {
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.west.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "good_sse_1" {
  bucket = aws_s3_bucket.ci-example.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}