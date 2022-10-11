# ---------------------------------------------------
# Creates subnets in a given VPC Variables
# ---------------------------------------------------

variable "vpc_apahce_id" {
  
}

variable "subnet_cidr" {
  description = "cidr range of subnet"
  default     = "10.0.16.0/20"
}

variable "subnet_tag" {
  description = "tag name for subnet"
  default     = "subnet_webserver"
}

variable "subnet_az" {  
}