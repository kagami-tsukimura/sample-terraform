resource "aws_subnet" "public_1a" {
  vpc_id = var.vpc_id

  availability_zone = "${var.region}a"

  cidr_block = var.public_subnet_cidr[0]

  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = var.vpc_id

  availability_zone = "${var.region}c"

  cidr_block = var.public_subnet_cidr[1]

  tags = {
    Name = "public-1c"
  }
}

resource "aws_subnet" "public_1d" {
  vpc_id = var.vpc_id

  availability_zone = "${var.region}d"

  cidr_block = var.public_subnet_cidr[2]

  tags = {
    Name = "public-1d"
  }
}

# Private Subnets
resource "aws_subnet" "private_1a" {
  vpc_id = var.vpc_id

  availability_zone = "${var.region}a"
  cidr_block        = var.private_subnet_cidr[0]

  tags = {
    Name = "private-1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id = var.vpc_id

  availability_zone = "${var.region}c"
  cidr_block        = var.private_subnet_cidr[1]

  tags = {
    Name = "private-1c"
  }
}

resource "aws_subnet" "private_1d" {
  vpc_id = var.vpc_id

  availability_zone = "${var.region}d"
  cidr_block        = var.private_subnet_cidr[2]

  tags = {
    Name = "private-1d"
  }
}
