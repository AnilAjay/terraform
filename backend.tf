terraform {
  backend "s3" {
    bucket = "sample105a"
    key     = "sample105a/terraform.tfstate"
    region  = "us-east-1"
  }
}