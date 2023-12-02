# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
  # Set Me
  access_key = ""
  # Set Me
  secret_key = ""
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-035d55281a86f9439"
  instance_type = "t2.micro"

  tags = {
    Name = "sample ec2 instance"
  }
}
