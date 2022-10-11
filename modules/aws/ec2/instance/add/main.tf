#-------------------------
# EC2 Instances
#-------------------------

resource "aws_instance" "instance_ws" {
  ami             = var.ami_instance
  instance_type   = var.instance_type
  # security_groups = [aws_security_group.server_sg.name]
  security_groups = [ aws_security_group.web_sg.name ]

  tags = {
    "Name" = var.instance_name
  }

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World from Server01" > insxdex.html
          python3 -m http.server 8080 &
          EOF  
}