module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = var.vpc_config["vpc_name"]
  cidr = "10.0.0.0/16"

  azs             = var.vpc_config["azs"]
  private_subnets = var.vpc_config["pri_subnets"]
  public_subnets  = var.vpc_config["pub_subnets"]

  enable_nat_gateway      = false
  enable_vpn_gateway      = false
  map_public_ip_on_launch = true

  tags = var.def_tags
}

resource "aws_vpc_endpoint" "s3-vpce" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = var.s3_vpce
  }
}

