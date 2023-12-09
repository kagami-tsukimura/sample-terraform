# Configure the AWS Provider
provider "aws" {
  region = local.aws_region
  # echo 'export TF_VAR_aws_access_key=YOUR_ACCESS_KEY' >> ~/.bashrc
  access_key = var.aws_access_key
  # echo 'export TF_VAR_aws_secret_key=YOUR_SECRET_KEY' >> ~/.bashrc
  secret_key = var.aws_secret_key
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }

  required_version = "1.6.5"
}
