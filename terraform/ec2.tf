resource "aws_key_pair" "ssh" {
  key_name   = "ivssh2"
  public_key = file("keys.pub")
  tags = {
    Name = "${var.tag_name}-key"
  }
}

resource "aws_instance" "EC2_public" {
  ami = var.AMI
  instance_type = var.ec2_type
  subnet_id = aws_subnet.public.id
  key_name = aws_key_pair.ssh.id
  vpc_security_group_ids = aws_security_group.allow_ssh.id
}

resource "aws_instance" "EC2_private" {
  ami = var.AMI
  instance_type = var.ec2_type
  subnet_id = aws_subnet.private.id
  key_name = aws_key_pair.ssh.id
  vpc_security_group_ids = aws_security_group.allow_ssh.id
}

#variable "subnet_ids" {
#  default =  [ aws_subnet.private.id, aws_subnet.public.id ]
#}
#resource "aws_instance" "EC2_private" {
#  count = var.count
#  subnet_id = "${element(var.subnet_ids, count.index)}"
#  ami = var.AMI
#  instance_type = var.ec2_type
#  key_name = aws_key_pair.ssh.id
#  vpc_security_group_ids = aws_security_group.allow_ssh.id
#}