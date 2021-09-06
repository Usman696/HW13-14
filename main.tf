provider "aws" {
  region = var.region
}

resource "aws_instance" "my_webserver" {
    ami           = "ami-03a71cec707bfc3d7"
    instance_type = var.instance_type

    vpc_security_group_ids = [
        aws_security_group.my_webserver.id
    ]

    user_data = file("user_data.sh")

    tags = {
      Name = var.name
      Owner = var.owner
      Project = var.project
    }
}

resource "aws_security_group" "my_webserver" {
  name        = "my web server security"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = var.server_port
    to_port          = var.server_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC, another port"
    from_port        = var.another_server_port
    to_port          = var.another_server_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
    Owner = var.owner
    Project = var.project
  }
}

output "public_ip" {
    value       = aws_instance.my_webserver.public_ip
    description = "The public IP address of the web server"
}