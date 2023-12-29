# vpc
resource "aws_vpc" "orjujeng_vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.perfix}_vpc"
  }
}

#inside subnet for ec2 
resource "aws_subnet" "orjujeng_inside_net_1a" {
  vpc_id            = aws_vpc.orjujeng_vpc.id
  cidr_block        = "10.1.101.0/24"
  availability_zone = var.availability_zone_1a
  tags = {
    Name = "orjujeng_inside_net_1a"
  }
}

resource "aws_subnet" "orjujeng_inside_net_1c" {
  vpc_id            = aws_vpc.orjujeng_vpc.id
  cidr_block        = "10.1.102.0/24"
  availability_zone = var.availability_zone_1c
  tags = {
    Name = "orjujeng_inside_net_1c"
  }
}

#private subnet for rds redis efs 
resource "aws_subnet" "orjujeng_private_net_1a" {
  vpc_id            = aws_vpc.orjujeng_vpc.id
  cidr_block        = "10.1.201.0/24"
  availability_zone = var.availability_zone_1a
  tags = {
    Name = "orjujeng_private_net_1a"
  }
}

resource "aws_subnet" "orjujeng_private_net_1c" {
  vpc_id            = aws_vpc.orjujeng_vpc.id
  cidr_block        = "10.1.202.0/24"
  availability_zone = var.availability_zone_1c
  tags = {
    Name = "orjujeng_private_net_1c"
  }
}

# #outside subnet for nat connect to internet gateway
# resource "aws_subnet" "orjujeng_outside_net_1a" {
#   vpc_id     = aws_vpc.orjujeng_vpc.id
#   cidr_block = "10.1.11.0/24"
#   availability_zone = var.availability_zone_1a
#   tags = {
#     Name = "orjujeng_outside_net_1a"
#   }
# }

# resource "aws_subnet" "orjujeng_outside_net_1c" {
#   vpc_id     = aws_vpc.orjujeng_vpc.id
#   cidr_block = "10.1.12.0/24"
#   availability_zone = var.availability_zone_1c
#   tags = {
#     Name = "orjujeng_outside_net_1c"
#   }
# }

#create internet gateway
resource "aws_internet_gateway" "orjujeng_internet_gateway" {
  vpc_id = aws_vpc.orjujeng_vpc.id

  tags = {
    Name = "orjujeng_internet_gateway"
  }
}

#route table
resource "aws_route_table" "orjujeng_outside_route_table" {
  vpc_id = aws_vpc.orjujeng_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.orjujeng_internet_gateway.id

  }
  tags = {
    Name = "orjujeng_outside_route_table"
  }
}

# resource "aws_route_table" "orjujeng_inside_route_table_1c" {
#   vpc_id   = aws_vpc.orjujeng_vpc.id

#   tags = {
#     Name = "orjujeng_inside_route_table_1c"
#   }
# }

# resource "aws_route_table" "orjujeng_inside_route_table_1a" {
#   vpc_id   = aws_vpc.orjujeng_vpc.id

#   tags = {
#     Name = "orjujeng_inside_route_table_1a"
#   }
# }

#assocation route table
resource "aws_route_table_association" "inside_1a_outside" {
  subnet_id      = aws_subnet.orjujeng_inside_net_1a.id
  route_table_id = aws_route_table.orjujeng_outside_route_table.id
}

resource "aws_route_table_association" "inside_1c_outside" {
  subnet_id      = aws_subnet.orjujeng_inside_net_1c.id
  route_table_id = aws_route_table.orjujeng_outside_route_table.id
}

#security group