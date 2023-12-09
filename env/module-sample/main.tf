module "vpc" {
  source = "../../modules/vpc"

  vpc_id = local.vpc_cidr
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

module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  security_group_id = module.security_group.alb_sg
  public_subnet_ids = module.subnet.public_subnet_ids
  allow_waf_cidr    = local.allow_waf_cidr
}
