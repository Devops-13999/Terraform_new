data "aws_availability_zones" "available" {
  state = "available"
}
locals {
   az = slice(data.aws_availability_zones.available.names,0,3)
}
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = element(local.az,0)
}
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}
resource "aws_route_table_association" "public_route" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.public_subnet.id
}