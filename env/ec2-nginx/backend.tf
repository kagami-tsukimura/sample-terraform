terraform {
  backend "s3" {
    bucket                   = "tfstate-s3-ec2"
    key                      = "terraform.tfstate"
    region                   = "ap-northeast-1"
    dynamodb_table           = "ec2-dynamodb"
    shared_credentials_files = ["$HOME/.aws/credentials"]
    profile                  = "sample"
  }
}
