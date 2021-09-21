variable "aws-region" {
  description = "Default Amazon region"
}

variable "profile_name" {
  description = "Profile name for authentication"
}
variable "access-key" {
  description = "Static credentials"
}
variable "secret-key" {
  description = "Static credentials"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "tags" {
  type = map(string)
  description = "A map of tags to assign to the resource"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the subnet"
}

variable "av_zona" {
  description = "The AZ for the subnet"
}

variable "AMI" {
  description = "AMI to use for the instance"
}

variable "ec2_type" {
  description = "AMI to use for the instance"
}

#variable "count" {
#  description = "Count of EC2 for one subnet"
#}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
}
