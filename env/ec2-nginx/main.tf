module "vpc" {
  source = "../../modules/vpc"

  vpc_id              = local.vpc_cidr
  ipv4_full_open_cidr = local.ipv4_full_open_cidr
  ipv6_full_open_cidr = local.ipv6_full_open_cidr
}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id              = module.vpc.vpc_id
  region              = local.aws_region
  public_subnet_cidr  = local.public_subnet_cidr
  private_subnet_cidr = local.private_subnet_cidr
}

module "security_group" {
  source = "../../modules/security-group"

  vpc_id              = module.vpc.vpc_id
  ipv4_full_open_cidr = local.ipv4_full_open_cidr
}

module "ec2" {
  source = "../../modules/ec2"

  ec2_ami           = local.ec2_ami
  ec2_instance_type = local.ec2_instance_type
  region            = local.aws_region
  public_subnet_ids = module.subnet.public_subnet_ids
  eni_private_ip    = local.eni_private_ip
  sg_id             = module.security_group.alb_sg
  igw               = module.vpc.igw
}
