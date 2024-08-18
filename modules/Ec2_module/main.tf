data "aws_ami" "ami_image" {
  most_recent = true
  filter {
    name = "name"
    values = [var.ami_name]
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}
locals {
   az = slice(data.aws_availability_zones.available.names,0,3)
}
resource "aws_instance" "apache_server" {
    instance_type = var.instance_type
    ami = data.aws_ami.ami_image.id
    availability_zone = element(local.az,0)
    vpc_security_group_ids = [ aws_security_group.security_group.id ]
    associate_public_ip_address = true
    subnet_id = var.subnet_id
    user_data = <<-EOF
  #!/bin/bash
  apt-get update -y
  apt-get install -y apache2
  systemctl start apache2
  systemctl enable apache2
  echo "Hello, World!" > /var/www/html/index.html
  EOF
    }
    
resource "aws_security_group" "security_group" {
  vpc_id = var.vpc_id
   egress{
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    ipv6_cidr_blocks = ["::/0"]
   }
   dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.port
      to_port =  ingress.value.port
      description = ingress.value.description
      cidr_blocks = [ "0.0.0.0/0" ]
      protocol = "tcp"
    }
   }
}