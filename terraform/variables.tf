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

variable "tag_name" {
  description = "A map of tags to assign to the resource"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the subnet"
}

variable "az" {
  description = "The AZ for the subnet"
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
}
