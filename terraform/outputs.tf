output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids_public" {
  value = aws_subnet.public.id
}

output "subnet_ids_private" {
  value = aws_subnet.private.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "default_security_group" {
  value = "${aws_vpc.main.default_security_group_id}"
}
