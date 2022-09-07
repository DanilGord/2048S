resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vpc"
  }
}

resource "aws_eip" "nat_eip" {
  count = var.subnet_count
  vpc   = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "prod-subnet-public" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, var.subnet_count + count.index)
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "subnet-public"
  }
}

resource "aws_subnet" "prod-subnet-private" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "subnet-private"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_nat_gateway" "nat-gw" {
  count         = var.availability_count
  subnet_id     = element(aws_subnet.prod-subnet-public.*.id, count.index)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)

  tags = {
    Name = "nat_private"
  }
}

resource "aws_route_table" "private" {
  count  = var.subnet_count
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat-gw.*.id, count.index)
  }
  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "private" {
  count          = var.availability_count
  subnet_id      = element(aws_subnet.prod-subnet-private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
