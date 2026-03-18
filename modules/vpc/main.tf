resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr

    tags = merge(var.vpc_tags, {
        Name = "${var.project_name}-${var.environment}-vpc"
    })
}

# internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.project_name}-igw"
    }
}

# Subnets Públicas
resource "aws_subnet" "public" {
  count = length(var.vpc_public_subnets)

  vpc_id = aws_vpc.main.id
  cidr_block = var.vpc_private_subnets[count.index]
  availability_zone = var.vpc_azs[count.index]

  tags = {
    Name = "${var.project_name}-public-${count.index}"
  }
}

# Subnets Privadas
resource "aws_subnet" "private" {
    count = length(var.vpc_private_subnets)

    vpc_id = aws_vpc.main.id
    cidr_block = var.vpc_private_subnets[count.index]
    availability_zone = var.vpc_azs[count.index]

    tags = {
        Name = "${var.project_name}-private-${count.index}"
    }
}

# Elastic Ip para NAT
resource "aws_eip" "nat" {
    domain = "vpc"
}

# Nat Gateway
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id

    tags = {
      Name ="${var.project_name}-nat"
    }

    depends_on = [ aws_internet_gateway.igw ]
}

# Route Table Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Rota Internet
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associação das Public Subnets
resource "aws_route_table_association" "public" {
  count = length(var.vpc_public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Route Table Privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Rota NAT para internet
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associação das Private Subnets
resource "aws_route_table_association" "private" {
  count = length(var.vpc_private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}