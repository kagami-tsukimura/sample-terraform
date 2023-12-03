# Provider
variable "aws_region" {
  description = "AWS Region"
  default     = "ap-northeast-1"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

# CIDR
variable "ipv4_full_open_cidr" {
  description = "IPv4 Full Open cidr"
  default     = "0.0.0.0/0"
  type        = string
}

variable "ipv6_full_open_cidr" {
  description = "IPv6 Full Open cidr"
  default     = "::/0"
  type        = string
}
