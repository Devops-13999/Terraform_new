output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "ig_id" {
  value = aws_internet_gateway.ig.id
}
output "route_table_id" {
  value = aws_route_table.route_table.id
}
output "az" {
  value = local.az
}