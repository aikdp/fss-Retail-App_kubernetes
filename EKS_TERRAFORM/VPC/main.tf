# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = local.module_name
    }
  )
}

# Subnets - Public
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true    # Assign a public IP address, default is false
  availability_zone = local.az_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-public-${local.az_zones[count.index]}"
    }
  )
}

# Subnets - Private 
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-private-${local.az_zones[count.index]}"
    }
  )
}

# Subnets - Database
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-database-${local.az_zones[count.index]}"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-igw"
    }
  )
}

# eip   
resource "aws_eip" "nat" {
  count = length(local.az_zones)
  domain   =  "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-nat-eip-${local.az_zones[count.index]}"
    }
  )
}

# Nat Gateway
resource "aws_nat_gateway" "gw" {
#   count = length(var.availability_zones)
  count = length(local.az_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-nat-gw-${local.az_zones[count.index]}"
    }
  )
}
# Route Table for Public Subnets

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

   tags = {
    Name = "${local.module_name}-rtb"
  }
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
# Route for Public Subnets
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-private-rtb-${local.az_zones[count.index]}"
    }
  )
}
# Route Table Association for Private Subnets
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Route for Private Subnets
resource "aws_route" "private" {
  count = length(var.private_subnet_cidrs)
  route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw[count.index].id
}

# Route Table for Database Subnets
resource "aws_route_table" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.module_name}-db-rtb-${local.az_zones[count.index]}"
    }
  )
}

# Route Table Association for Database Subnets
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database[count.index].id
}   

# Route for Database Subnets
resource "aws_route" "database" {
  count = length(var.database_subnet_cidrs)
  route_table_id = aws_route_table.database[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw[count.index].id
}
