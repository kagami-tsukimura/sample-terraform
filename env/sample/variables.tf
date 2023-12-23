# VPC
variable "vpc_cidr" {
  description = "cidr block for vpc"
  default     = "10.0.0.0/16"
  type        = string
}

# Subnet
variable "subnet_cidr" {
  description = "cidr block for subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  type        = list(string)
}

variable "subnet_az" {
  description = "AZ for subnet"
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
  type        = list(string)
}

# ENI
variable "eni_private_ip" {
  description = "ENI private ip"
  default     = "10.0.1.50"
  type        = string
}

# EC2
variable "ec2_ami" {
  description = "AMI(Amazon Linux2) for EC2"
  default     = "ami-035d55281a86f9439"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
  type        = string
}
