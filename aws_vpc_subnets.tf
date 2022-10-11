# ---------------------------------------------------
# Creates subnets in a given VPC
# ---------------------------------------------------

resource "aws_subnet" "subnet_default" {
  # vpc_id     = aws_default_vpc.vpc_default.id
  vpc_id            = var.vpc_apahce_id
  availability_zone = var.subnet_az
  cidr_block        = var.subnet_cidr

  tags = {
    "Name" = var.subnet_tag
  }
}