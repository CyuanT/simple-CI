# ALB security Group: Edit to restrict access to the application
# resource "aws_security_group" "lb" {
#     name        = "cb-load-balancer-security-group"
#     description = "controls access to the ALB"
#     vpc_id      = aws_vpc.main.id

#     ingress {
#         protocol    = "tcp"
#         from_port   = var.app_port
#         to_port     = var.app_port
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         protocol    = "-1"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }

resource "aws_security_group" "ty-sg" {

  name        = var.sg_name
  description = var.sg_name
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = var.sg_name
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1" # semantically equivalent to all ports
  }
}