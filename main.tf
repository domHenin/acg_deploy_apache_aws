provider "aws" {
  region = var.aws_region
}

# resource "aws_default_vpc" "vpc_default" {
#   tags = {
#     "Name" = "default-vpc"
#   }
# }

resource "aws_vpc" "vpc_apache" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet_ws" {
  # vpc_id     = aws_default_vpc.vpc_default.id
  vpc_id = aws_vpc.vpc_apache.id
  availability_zone = element(data.aws_availability_zones.azs_apache.names, 0)
  cidr_block = var.subnet_cidr

  tags = {
    "Name" = var.subnet_tag
  }
}

resource "aws_internet_gateway" "ig_ws" {
  # vpc_id = aws_default_vpc.vpc_apache.id
  vpc_id = aws_vpc.vpc_apache.id

  tags = {
    "Name" = var.ig_tag
  }
}

resource "aws_security_group" "sg_ws" {
  name        = "allow TLS/80 && TLS/22"
  description = "allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc_apache.id
  # vpc_id = aws_default_vpc.vpc_default.id

  ingress {
    description = "TLS traffic HTTP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS traffic HTTP/22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "internet-gateway-sg"
  }
}

data "aws_route_table" "main_route_table" {
  filter {
    name = "association.main"
    values = ["true"]
  }

  filter {
    name = "vpc-id"
    values = [aws_vpc.vpc_apache.id]
  }
}

resource "aws_default_route_table" "internet_route" {
  default_route_table_id = data.aws_route_table.main_route_table.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_ws.id
  }

  tags = {
    "Name" = "terrform_routeTable"
  }
}

data "aws_availability_zones" "azs_apache" {
  state = "available"  
}

resource "tls_private_key" "priv_key" {
  algorithm = "RSA"
  rsa_bits = 4096 
}

data "aws_route_table" "route_table_main" {
  filter {
    name = "association.main"
    values = ["true"]
  }
  filter {
    name = "vpc-id"
    values = [aws_vpc.vpc_apache.id]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "provision_key"
  public_key = tls_private_key.priv_key.public_key_openssh
  # public_key = file("~/.ssh/id_rsa")
}

data "aws_ami" "ubuntu_ami" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


resource "aws_instance" "instance_ws" {
  ami           = data.aws_ami.ubuntu_ami.id
  key_name      = aws_key_pair.deployer.key_name
  instance_type = var.instance_type
  associate_public_ip_address = true

  # connection {
  #   type        = "ssh"
  #   user        = "admin"
  #   private_key = file("~/.ssh/id_rsa")
  #   host        = self.public_ip
  # }

  # user_data = file("files/install_nginx.sh")

  # depends_on = [
  #   aws_internet_gateway.ig_ws
  # ]
}


output "web_server_ip" {
  value = aws_instance.instance_ws.public_ip  
}