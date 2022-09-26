variable "aws_region" {
  description = "desired region for infrastructure"
  default     = "us-east-1a"
}

variable "ig_tag" {
  description = "tag name for internet gateway webserver"
  default     = "ig-webserver"
}

variable "subnet_cidr" {
  description = "cidr range of subnet"
  default     = "10.0.16.0/20"
}

variable "subnet_tag" {
  description = "tag name for subnet"
  default     = "subnet_webserver"
}

variable "vpc_cidr" {
  description = "existing cidr range"
  default     = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "id of existing VPC"
  default     = "vpc-03730028866386a6d"
}

variable "route_table_id" {
  description = "route table id"
  default     = "rtb-01f77f141a8fe81e3"
}

variable "instance_type" {
  description = "type of desired instance"
  default     = "t3.micro"
}