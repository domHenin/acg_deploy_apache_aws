variable "aws_region" {
    description = "desired region for infrastructure"
    default = "us-east-1"  
}

variable "ig_tag" {
    description = "tag name for internet gateway webserver"
    default = "ig-webserver"  
}

variable "subnet_cidr" {
    description = "cidr range of subnet"
    default = "172.61.0.0/20"  
}

variable "subnet_tag" {
    description = "tag name for subnet"
    default = "subnet_webserver"  
}

variable "vpc_cidr" {
    description = "existing cidr range"
    default = ""
}

variable "vpc_id" {
    description = "id of existing VPC"
    default = "vpc-0896bbf0e944782d8"
  
}