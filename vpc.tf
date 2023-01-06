# Create a VPC
resource "aws_vpc" "pickme_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "pickme_vpc"
  }
}

# Create two public subnets
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.pickme_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.pickme_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_b"
  }
}

resource "aws_db_subnet_group" "pickme-subnet" {
  name = "pickme-subnet-group"
  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
  ]
}

resource "aws_internet_gateway" "pickme-igw" {
  vpc_id = aws_vpc.pickme_vpc.id
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.pickme_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pickme-igw.id
  }

}
