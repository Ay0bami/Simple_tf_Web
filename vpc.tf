# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  public_cidrs = ["10.15.1.0/24", "10.15.2.0/24"]
}

# Create a new VPC 
resource "aws_vpc" "midterm" {
  cidr_block       = "10.15.0.0/16"
  instance_tenancy = "default"


}


# Add provisioning of the public subnet1 in the custom VPC
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.midterm.id
  cidr_block        = local.public_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]
}

# Add provisioning of the public subnet2 in the custom VPC
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.midterm.id
  cidr_block        = local.public_cidrs[1]
  availability_zone = data.aws_availability_zones.available.names[1]
}


# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.midterm.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.midterm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id

  }
}

# Associate subnets with the custom route table
resource "aws_route_table_association" "public_route_table_association-1" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

# Associate subnets with the custom route table
resource "aws_route_table_association" "public_route_table_association-2" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}
