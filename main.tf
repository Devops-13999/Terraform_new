provider "aws" {
  region = var.region
}
module "VPC_module" {
  source = "./modules/VPC_module"
  availability_zone = element(module.VPC_module.az, 0)
  region = var.region
}

module "EC2_Apace" {
  source = "./modules/Ec2_module"
  subnet_id     = module.VPC_module.subnet_id
  vpc_id        = module.VPC_module.vpc_id
  availability_zone = element(module.VPC_module.az, 0)
  region = var.region
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = module.VPC_module.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = element(module.VPC_module.az, 1)
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "association_2" {
  route_table_id = module.VPC_module.route_table_id
  subnet_id      = module.VPC_module.subnet_id
}

resource "aws_instance" "new" {
  availability_zone = element(module.VPC_module.az, 1)
  vpc_security_group_ids = [module.EC2_Apace.security_group_id]
  subnet_id = aws_subnet.public_subnet_2.id
  associate_public_ip_address = true
  ami = module.EC2_Apace.ami_id
  instance_type = lookup(var.instance_type2 , terraform.workspace , "t2.micro")
  tags = {
    Name = "new_instance"
  }
}

resource "aws_s3_bucket" "name" {
  bucket = "ok-bucket-us-east-tera-mera"
}
