# resource "aws_s3_bucket" "ci-example" {
#   region        = "us-east-1"
#   bucket        = "ce7-ty-terraform-ci-bucket"
#   force_destroy = true

#   tags = {
#     Name = "ci-example-${data.aws_caller_identity.current.account_id}"
#   }
#   versioning {
#     enabled = true
#   }
#   logging {
#     target_bucket = "${aws_s3_bucket.ci-example.id}"
#     target_prefix = "log/"
#   }
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         kms_master_key_id = "${aws_kms_key.mykey.arn}"
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }
#   acl           = "private"
# }



  #checkov:skip=CKV_AWS_18:Ensure the S3 bucket has access logging enabled
  #checkov:skip=CKV2_AWS_61:Ensure that an S3 bucket has a lifecycle configuration
  #checkov:skip=CKV2_AWS_62:Ensure S3 buckets should have event notifications enabled
  #checkov:skip=CKV_AWS_145:Ensure that S3 buckets are encrypted with KMS by default
  #checkov:skip=CKV2_AWS_6:Ensure that S3 bucket has a Public Access block
  #checkov:skip=CKV_AWS_144:Ensure that S3 bucket has cross-region replication enabled
  #checkov:skip=CKV_AWS_21:Ensure all data stored in the S3 bucket have versioning enabled