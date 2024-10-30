resource "aws_s3_bucket" "ci-example" {
  region        = "us-east-1"
  bucket        = "ce7-ty-terraform-ci-bucket"
  force_destroy = true

  tags = {
    Name = "ci-example-${data.aws_caller_identity.current.account_id}"
  }
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.ci-example.id}"
    target_prefix = "log/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.mykey.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
  acl           = "private"
}