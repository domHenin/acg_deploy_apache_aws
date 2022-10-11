# ---------------------------------------------------
# Creates a VPC
# ---------------------------------------------------

resource "aws-vpc" "vpc_default" {
  default = true

  tags = {
    "Name" = "default-vpc"
  }
}