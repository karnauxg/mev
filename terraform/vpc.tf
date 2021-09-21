resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
    Name = "${var.tag_name}-vpc"
  }
}
#Create public and private subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = var.av_zona
  tags = {
    Name = "${var.tag_name}-public"
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.av_zona
  tags = {
    Name = "${var.tag_name}-private"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.tag_name}-gw"
  }
}

#resource "aws_eip" "eip" {
#  vpc        = true
#  depends_on = ["aws_internet_gateway.igw"]
#}

# resource "aws_nat_gateway" "gateway" {
#     allocation_id = aws_eip.eip.id
#     subnet_id     = aws_subnet.public.id
#     depends_on    = ["aws_internet_gateway.igw"]
# }

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [aws_internet_gateway.igw]

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = 0
      cidr_blocks      = ["10.10.11.0/24"]
      ipv6_cidr_blocks = ["::/0"]
      self = true
      prefix_list_ids = []
      security_groups = []
    },
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = 0
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      self = alltrue(aws_internet_gateway.igw.id)
      prefix_list_ids = []
      security_groups = []
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = alltrue(aws_internet_gateway.igw.id)
      description = "allow ssh"
    }
  ]

  tags = {
    Name = "${var.tag_name}-sg"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.public_subnet_cidr
    gateway_id = aws_internet_gateway.igw.id
#    instance_id = aws_instance.EC2_public.arn
  }
  tags = {
    Name = "${var.tag_name}-rt-public"
  }
}

# resource "aws_route_table" "rt_private" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "${aws_nat_gateway.gw.id}"
#   }
#   tags {
#     Name = "${var.short_name}-rt-private"
#   }
# }

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.rt_public.id
}

# resource "aws_route_table_association" "private" {
#   subnet_id = "${aws_subnet.private.id}"
#   route_table_id = aws_route_table.rt_private.id
# }
