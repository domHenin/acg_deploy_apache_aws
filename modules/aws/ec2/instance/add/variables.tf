#-------------------------
# EC2 Instances Variables
#-------------------------

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

variable "app_name" {
  description = "name of apache"
  type = string
  default = "apache-ws"  
}