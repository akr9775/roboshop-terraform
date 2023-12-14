terraform {
  backend "s3" {
    bucket = "akr975797"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
