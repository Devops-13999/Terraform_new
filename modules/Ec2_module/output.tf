output "security_group_id" {
  value = aws_security_group.security_group.id
}

output "ec2_instance_id" {
  value = aws_instance.apache_server.id
}
output "ami_id" {
  value = data.aws_ami.ami_image.id
}
output "az" {
  value = local.az
}