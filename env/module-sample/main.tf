module "vpc" {
  source = "../../modules/vpc"

  vpc_id = local.vpc_cidr

}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id = module.vpc.vpc_id
}
