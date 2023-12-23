variable "ec2_ami" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "region" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "eni_private_ip" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "igw" {
  type = any
}
