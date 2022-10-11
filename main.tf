provider "aws" {
  region = var.aws_region
}

//moved to modules/
# resource "aws-vpc" "vpc_default" {
#   default = true

#   tags = {
#     "Name" = "default-vpc"
#   }
# }

# data "aws_subnet_ids" "default_subnet" {
#   vpc_id = aws_default_vpc.vpc_default.id
# }

# resource "aws_security_group" "web_sg" {
#   # name = "${var.app_name}-instance-security-group"
# }

# resource "aws_security_group_rule" "allow_http_inbound" {
#   type              = "ingress"
#   security_group_id = aws_security_group.web_sg.id

#   from_port   = 8080
#   to_port     = 8080
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }

resource "aws_instance" "instance_ws" {
  ami           = var.ami_instance
  instance_type = var.instance_type
  # security_groups = [aws_security_group.server_sg.name]
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    "Name" = var.instance_name
  }

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World from Server01" > insxdex.html
          python3 -m http.server 8080 &
          EOF  
}

# resource "aws_vpc" "vpc_apache" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_hostnames = true
#   enable_dns_support   = true

#   tags = {
#     "Name" = "apache-vpc"
#   }
# }

# resource "aws_subnet" "subnet_ws" {
#   # vpc_id     = aws_default_vpc.vpc_default.id
#   vpc_id            = aws_vpc.vpc_apache.id
#   availability_zone = element(data.aws_availability_zones.azs_apache.names, 0)
#   cidr_block        = var.subnet_cidr

#   tags = {
#     "Name" = var.subnet_tag
#   }
# }

# resource "aws_internet_gateway" "ig_ws" {
#   # vpc_id = aws_default_vpc.vpc_apache.id
#   vpc_id = aws_vpc.vpc_apache.id

#   tags = {
#     "Name" = var.ig_tag
#   }
# }

# resource "aws_security_group" "sg_ws" {
#   name        = "allow TLS/80 && TLS/22"
#   description = "allow TLS inbound traffic"
#   vpc_id      = aws_vpc.vpc_apache.id
#   # vpc_id = aws_default_vpc.vpc_default.id

#   ingress {
#     description = "TLS traffic HTTP/80"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "TLS traffic SSH/22"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }


#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     "Name" = "internet-gateway-sg"
#   }
# }

# data "aws_route_table" "main_route_table" {
#   filter {
#     name   = "association.main"
#     values = ["true"]
#   }

#   filter {
#     name   = "vpc-id"
#     values = [aws_vpc.vpc_apache.id]
#   }
# }

# resource "aws_default_route_table" "internet_route" {
#   default_route_table_id = data.aws_route_table.main_route_table.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.ig_ws.id
#   }

#   tags = {
#     "Name" = "terrform_routeTable"
#   }
# }

# data "aws_availability_zones" "azs_apache" {
#   state = "available"
# }

# data "aws_route_table" "route_table_main" {
#   filter {
#     name   = "association.main"
#     values = ["true"]
#   }
#   filter {
#     name   = "vpc-id"
#     values = [aws_vpc.vpc_apache.id]
#   }
# }

# # resource "tls_private_key" "priv_key" {
# #   algorithm = "RSA"
# #   rsa_bits  = 4096
# # }

# # Key Pair
# resource "aws_key_pair" "deployer" {
#   key_name   = "provision_key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# # resource "aws_key_pair" "deployer" {
# #   key_name   = "provision_key"
# #   public_key = file("~/.ssh/id_rsa.pub")
# #   # public_key = tls_private_key.priv_key.public_key_openssh
# #   # public_key = file("~/.ssh/id_rsa")
# # }

# data "aws_ami" "ami_web_server" {
#   owners      = ["self"]
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-kernel-5.10-hvm-2.0.-*"]
#   }
# }


# resource "aws_instance" "instance_ws" {
#   ami                         = data.aws_ami.ami_web_server.id
#   key_name                    = aws_key_pair.deployer.key_name
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.sg_ws.id]
#   subnet_id                   = aws_subnet.subnet_ws.id

#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum -y install httpd && sudo systemctl start httpd",
#       "echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
#       "sudo mv index.html /var/www/html/"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file("~/.ssh/id_rsa")
#       host        = self.public_ip
#     }
#   }

#   tags = {
#     Name = "webserver"
#   }

# }


output "web_server_ip" {
  value = aws_instance.instance_ws.public_ip
}
