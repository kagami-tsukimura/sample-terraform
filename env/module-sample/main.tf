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
