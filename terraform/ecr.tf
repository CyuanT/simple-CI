# Use this to create your own ecr private registry
# Afterwards, you may also add in a Dockerfile to create a Docker image
# and push the image to your private registry
# You can then replace task definition > image to point to your 
# created image.

# The challenge is to create the ECR before docker image can be pushed

# resource "aws_ecr_repository" "ecr_repo" {
#   name                 = "ty_capstone_ecr" # Change it accordingly
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   force_delete = true # this would allow my ecr to be removed forcefully
# }