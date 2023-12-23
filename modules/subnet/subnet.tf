resource "aws_subnet" "public_1a" {
  vpc_id = var.vpc_id

  availability_zone       = "${var.region}a"
  cidr_block              = var.public_subnet_cidr[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = var.vpc_id

  availability_zone       = "${var.region}c"
  cidr_block              = var.public_subnet_cidr[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1c"
  }
}

resource "aws_subnet" "public_1d" {
  vpc_id = var.vpc_id

  availability_zone       = "${var.region}d"
  cidr_block              = var.public_subnet_cidr[2]
  map_public_ip_on_launch = true

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

# Subnet to Route table
resource "aws_route_table_association" "public_1a_association" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = var.route_table_id
}

resource "aws_route_table_association" "public_1c_association" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = var.route_table_id
}

resource "aws_route_table_association" "public_1d_association" {
  subnet_id      = aws_subnet.public_1d.id
  route_table_id = var.route_table_id
}
