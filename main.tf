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

resource "aws_security_group" "sg_ws" {
  name = "allow TLS/80 && TLS/22"
  description = "allow TLS inbound traffic"
  vpc_id = aws_vpc.vpc_apache.id

  ingress = {
    description = "TLS traffic HTTP/80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }

  ingress {
      description = "TLS traffic HTTP/80"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "provision_key"
  public_key = file("~/.ssh/id_rsa.pub")
  
}

data "aws_ami" "ubuntu_ami" {
  owners = [ " 099720109477" ]
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-*"]
  }
}


resource "aws_instance" "instance_ws" {
  ami = data.aws_ami.ubuntu_ami.id
  key_name = aws_key_pair.deployer.key_name
  instance_type = var.instance_type

  connection {
    type = "ssh"
    user = "admin"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip 
  }   

  user_data = file("files/install_nginx.sh")


    depends_on = [
      aws_internet_gateway.name
    ]
  
}