variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ingress_rules" {
  type = list(object({
    port = number
    description = string
  }))
  default = [ {
    port = 80
    description = "Ingress rule for port 80"
   },
   {
    port = 443
    description = "Ingress rule for port 443"
   },
   {
    port = 22
    description = "Ingress rule for port 22"
   }]
  } 
  variable "ami_name" {
    type = string
    default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240701"
    
  }
  variable "region" {
    type = string
    
  }
  variable "subnet_id" {
    type = string
  }
  variable "vpc_id" {
  type = string
}
 variable "availability_zone" {
  type = string
}
