provider "aws" {
  profile    = var.profile_name
  region     = var.aws-region
  access_key = var.access-key
  secret_key = var.secret-key
}


// Provider for users with access and secret keys
//provider "aws" {
//  access_key = "${var.aws_access_key}"
//  secret_key = "${var.aws_secret_key}"
//  region     = "${var.aws_region}"
//}

//provider "random" {
//}
//
//terraform {
//  backend "s3" {}
//}
