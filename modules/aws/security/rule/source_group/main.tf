# ---------------------------------------------------
# SECURITY Rule -- Source Group -- 
# Provides a security group rule resource.
# Represents a single ingress or egress group rule,
# which can be added to external Security Groups.
# ---------------------------------------------------

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id

  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}