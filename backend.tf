terraform {
  backend "s3" {
    bucket = "ok-bucket-us-east-tera-mera"
    region = "us-east-1"
    key = "terraform.tfstate"  
    dynamodb_table = "terraformlock"
  }
}