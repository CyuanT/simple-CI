# variable "backend_conf" {
#   description = "backend configurations"
#   type = object({
#     bucket = string,
#     key    = string,
#     region = string
#   })

#   default = {
#     "bucket" = "sctp-ce7-tfstate",
#     "key"    = "ce7-TanYuan-kube.tfstate",
#     "region" = "us-east-1"
#   }
# }

variable "s3_vpce" {
  description = "name of vpce for S3"
  type        = string
  default     = "TanYuan-tf-vpce-s3-ECS"
}

variable "sg_name" {
  description = "Name of Terraform EC2 security group"
  type        = string
  default     = "ce7-ty-sg-ECS"
}

# Referenced from https://terrateam.io/blog/terraform-types/
variable "vpc_config" {
  description = "vpc config"
  type = object({
    vpc_name    = string,
    azs         = list(string),
    pri_subnets = list(string),
    pub_subnets = list(string)
  })

  default = {
    "vpc_name"    = "ce7-ty-ECS-vpc"
    "azs"         = ["us-east-1a", "us-east-1b"],
    "pri_subnets" = ["10.0.1.0/24", "10.0.2.0/24"],
    "pub_subnets" = ["10.0.101.0/24", "10.0.102.0/24"]
  }
}

variable "def_tags" {
  description = "default tags"
  type = object({
    creator     = string,
    environment = string
  })
  default = {
    "creator"     = "ce7-ty-ECS",
    "environment" = "dev"
  }
}

# variable "vpc_id" {
#   description = "The ID of the VPC"
#   type        = string
#   default     = "vpc-0aa58eaabb536e7d3"
# }

variable "ex_role_arn" {
    description = "The arn of execution role"
    type        = string
    default     = "arn:aws:iam::255945442255:role/ecsTaskExecutionRole"
}

# variable "sg_id" {
#     description = "The security group id"
#     type        = string
#     default     = "sg-0d27b7c2a485d0c74"
# }