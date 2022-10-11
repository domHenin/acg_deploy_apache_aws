# ---------------------------------------------------
# Creates a VPC Variables
# ---------------------------------------------------

variable "vpc_cidr" {
  description = "existing cidr range"
  default     = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "id of existing VPC"
  default     = "vpc-03730028866386a6d"
}   