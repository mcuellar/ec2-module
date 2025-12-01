# Create a custom VPC
resource "aws_vpc" "custom" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "custom-vpc-example"
    Environment = "development"
    Example     = "custom-vpc"
  }
}

# Create a subnet in the custom VPC
resource "aws_subnet" "custom" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "custom-subnet-example"
    Environment = "development"
    Example     = "custom-vpc"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "custom" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name        = "custom-igw-example"
    Environment = "development"
    Example     = "custom-vpc"
  }
}

# Create a route table
resource "aws_route_table" "custom" {
  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom.id
  }

  tags = {
    Name        = "custom-rt-example"
    Environment = "development"
    Example     = "custom-vpc"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "custom" {
  subnet_id      = aws_subnet.custom.id
  route_table_id = aws_route_table.custom.id
}

# Data source to get available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Use the EC2 module with custom VPC
module "ec2_instance" {
  source = "../.."

  instance_name = "custom-vpc-example-instance"
  os_type       = "ubuntu"
  instance_type = "t3.small"

  vpc_id    = aws_vpc.custom.id
  subnet_id = aws_subnet.custom.id

  allowed_ssh_cidr_blocks = [var.allowed_ssh_cidr]

  root_volume_size = 20
  root_volume_type = "gp3"

  tags = {
    Environment = "development"
    Example     = "custom-vpc"
  }
}
