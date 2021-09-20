resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags {
    Name = "${var.tag_name}-vpc"
  }
}
#Create public and private subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = var.az
  tags {
    Name = "${var.tag_name}-public"
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.az
  tags {
    Name = "${var.tag_name}-private"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = "${var.tag_name}-gw"
  }
}

#resource "aws_eip" "nat" {
#}

#Create NAT Gateway
resource "aws_nat_gateway" "ngw" {
#  allocation_id = "${aws_eip.nat.id}"
  subnet_id = aws_subnet.public.id
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags {
    Name = "${var.short_name}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }
  tags {
    Name = "${var.short_name}-private"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}
