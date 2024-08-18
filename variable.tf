variable "instance_type2" {
  type    = map(string)

  default = {
    "prod" = "t2.micro"
    "dev" = "t2.medium"
  }
}
variable "region" {
  type    = string
  default = "us-east-1"
}
