provider "aws"{}


resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.vpc_apache.id

    tags = {
      "Name" = var.ig_tag
    }
}

resource "aws_subnet" "subnet_ws" {
    vpc_id = aws_vpc.vpc_apache.id
    cidr_block = "172.61.0.0/20"

    tags = {
      "Name" = var.subnet_tag
    }
}

resource "aws_vpc" "vpc_apache" {
    vpc_id = var.vpc_id
    enable_dns_hostnames = true
    enable_dns_support = true
}


resource "aws_instance" "instance_ws" {



    depends_on = [
      aws_internet_gateway.name
    ]
  
}