variable "aws_region" {
  description = "desired region for infrastructure"
  default     = "us-east-1a"
}

variable "instance_name" {
  description = "name of instance"
  type        = string
  default     = "apache-webserver"
}

variable "instance_type" {
  description = "type of instance"
  type = string
  default = "t3.micro"
  
}

# variable "default_subnet" {}

variable "ami_instance" {
  description = "ami for instance"
  type = string
  default = "ami-0149b2da6ceec4bb0"
}

variable "app_name" {
  description = "name of apache"
  type = string
  default = "apache-ws"
  
}


# variable "ig_tag" {
#   description = "tag name for internet gateway webserver"
#   default     = "ig-webserver"
# }

# variable "subnet_cidr" {
#   description = "cidr range of subnet"
#   default     = "10.0.16.0/20"
# }

# variable "subnet_tag" {
#   description = "tag name for subnet"
#   default     = "subnet_webserver"
# }

# variable "vpc_cidr" {
#   description = "existing cidr range"
#   default     = "10.0.0.0/16"
# }

# variable "vpc_id" {
#   description = "id of existing VPC"
#   default     = "vpc-03730028866386a6d"
# }

# variable "route_table_id" {
#   description = "route table id"
#   default     = "rtb-01f77f141a8fe81e3"
# }

# variable "instance_type" {
#   description = "type of desired instance"
#   default     = "t3.micro"
# }
