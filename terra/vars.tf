variable "key_nm" {
  default = "mykey"
}

variable "pub_key" {
  default = "./terra/terra_rsa.pub"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "instance_name" {
  default = "DemoEC2"
}

variable "vpc_name" {
  default = "vpc-1841aa60"
}

variable "pubsub" {
  default = "subnet-32461468"
}

variable "igname" {
  default = "igw-706e4a16"
}

variable "path_to_key" {
  default = "./terra/terra_rsa"
}

variable "myuserdata" {
  default = "./terra/userdata.txt"
}

variable "inst_type" {
  default = "t2.micro"
}

variable "pub_vpc_cidr" {
  default = "172.31.128.0/20"
}
