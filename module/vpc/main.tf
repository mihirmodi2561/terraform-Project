resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block #10.0.0.0/16
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#Create internet_gatway and attach with VPC
resource "aws_internet_gateway" "internet_gatway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

#Use data ssource to get all AZ in region
data "aws_availability_zones" "available_zones" {}

# create public subnet az1 -->3
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr_block                     #"10.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[0] #"us-east-1"                      
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet AZ1"
  }
}

# create public subnet az2 --> 4
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2_cidr_block                     # "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[1] # "us-east-2" 
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet AZ2"
  }
}

# create route table and add public route --> 5
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gatway.id
  }
  tags = {
    Name = "Public route table"
  }
}

# associate public subnet az1 to "public route table" --> 6
resource "aws_route_table_association" "associate_public_subnet_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table" --> 7
resource "aws_route_table_association" "associate_public_subnet_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app subnet az1 --> 8
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_az1_cidr_block # "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private app ssubnet AZ1"
  }
}

# create private app subnet az2 --> 9 
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_az2_cidr_block # "10.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_app_subnet_az2"
  }
}

# create private data subnet az1 --> 10
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_az1_cidr_block #"10.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_data_subnet_AZ1"
  }
}

# create private data subnet az2 --> 11
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_az2_cidr_block # "10.0.5.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_data_subnet_AZ2"
  }
}
