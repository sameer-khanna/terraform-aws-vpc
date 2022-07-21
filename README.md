# AWS VPC Terraform module

Creates a VPC and all the related networking complete with subnets, route tables, Internet gateway and VPC endpoints.
 
## Sample usage

```hcl
locals {
 vpc_endpoints = {
    ssm = {
      service_name      = "com.amazonaws.us-east-1.ssm"
      vpc_endpoint_type = "Interface"
    }
    ssmmessages = {
      service_name      = "com.amazonaws.us-east-1.ssmmessages"
      vpc_endpoint_type = "Interface"
    }
  }
}

data "aws_subnets" "app_subnets" {
  filter {
    name   = "tag:Name"
    values = ["app-*"]
  }
  filter {
    name   = "availabilityZone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  }
}

module "vpc" {
  source  = "app.terraform.io/sameer-primary/vpc/aws"
  version = "1.0.2"
  web_subnet_count      = 4
  app_subnet_count      = 4
  db_subnet_count       = 4
  reserved_subnet_count = 4
  web_cidr_blocks       = [for i in range(0, 4, 1) : cidrsubnet("10.16.0.0/0", 4, i)]
  app_cidr_blocks       = [for i in range(4, 8, 1) : cidrsubnet("10.16.0.0/0", 4, i)]
  db_cidr_blocks        = [for i in range(8, 12, 1) : cidrsubnet("10.16.0.0/0", 4, i)]
  reserved_cidr_blocks  = [for i in range(12, 16, 1) : cidrsubnet("10.16.0.0/0", 4, i)]
  vpc_endpoints         = local.vpc_endpoints
  security_group_ids = [
    module.compute.app_security_group_id
  ]
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  subnet_ids          = [data.aws_subnets.app_subnets.ids[0]]
}
```