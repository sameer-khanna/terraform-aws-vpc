resource "random_integer" "random-int" {
  min = 1
  max = 100
}

data "aws_availability_zones" "availability-zones" {
}

resource "random_shuffle" "random" {
  input        = data.aws_availability_zones.availability-zones.names
  result_count = var.subnet_count
}


resource "aws_vpc" "sample-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = "sample-vpc-${random_integer.random-int.id}"
  }
}

resource "aws_subnet" "web-subnets" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.sample-vpc.id
  cidr_block              = var.web_subnet_cidr[count.index]
  map_public_ip_on_launch = var.web_map_public_ip_on_launch
  availability_zone       = random_shuffle.random.result[count.index]
  tags = {
    "Name" = "web-${count.index + 1}"
  }
}

resource "aws_subnet" "app-subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.app_subnet_cidr[count.index]
  availability_zone = random_shuffle.random.result[count.index]
  tags = {
    "Name" = "app-${count.index + 1}"
  }
}

resource "aws_subnet" "db-subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.db_subnet_cidr[count.index]
  availability_zone = random_shuffle.random.result[count.index]
  tags = {
    "Name" = "db-${count.index + 1}"
  }
}

resource "aws_subnet" "reserved-subnets" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.reserved_subnet_cidr[count.index]
  availability_zone = random_shuffle.random.result[count.index]
  tags = {
    "Name" = "reserved-${count.index + 1}"
  }
}