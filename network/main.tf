# Set the AWS region
provider "aws" {
  region = "us-east-1"
}

# Get availability_zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the Prod VPC
data "aws_vpc" "vpc" {
  default = true
}

# public subnets
data "aws_subnet" "subnets_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}


# Create an Internet Gateway
# resource "aws_internet_gateway" "my_igw" {
#   vpc_id = aws_vpc.vpc.id
#   tags = merge(
#     var.default_tags, {
#       Name = "${var.prefix}-igw"
#     }
#   )
# }

# Create a route table for the Internet access
# resource "aws_route_table" "rt_internet_access" {
#   vpc_id = aws_vpc.vpc.id
#   tags = merge(
#     var.default_tags, {
#       Name = "${var.prefix}-route-table"
#     }
#   )  
# }

# resource "aws_route" "route_internet_access" {
#   route_table_id         = aws_route_table.rt_internet_access.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.my_igw.id
# }

# resource "aws_route_table_association" "rt_association_internet_access" {
#   route_table_id = aws_route_table.rt_internet_access.id
#   subnet_id      = aws_subnet.subnets_public.id
# }