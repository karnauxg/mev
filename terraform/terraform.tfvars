aws-region = "eu-west-1"
profile_name = "mev"
#access-key = ""
#secret-key = ""
vpc_cidr = "10.10.0.0/16"
tags = {
  Name = "mev"
  Company = "Test"
}
public_subnet_cidr = "10.10.10.0/24"
private_subnet_cidr = "10.10.11.0/24"
map_public_ip_on_launch = true
av_zona = "eu-west-1a"
AMI = "ami-2757f631"
ec2_type = "t2.micro"
#count = 1
