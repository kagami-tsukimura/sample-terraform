terraform {
  backend "s3" {
    bucket                   = "tfstate-s3-kagami-20231209"
    key                      = "terraform.tfstate"
    region                   = "ap-northeast-1"
    dynamodb_table           = "tfstate-dynamodb"
    shared_credentials_files = ["$HOME/.aws/credentials"]
    profile                  = "sample"
  }
}
