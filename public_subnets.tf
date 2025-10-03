# =============================================================================
# PUBLIC SUBNETS
# =============================================================================
#
# Configuração de subnets públicas para recursos que precisam de acesso
# direto à internet (ALB, NAT Gateway, Bastion Hosts, etc.).
#
# Características:
# - Acesso direto à internet via Internet Gateway
# - Distribuídas em 3 AZs para alta disponibilidade
# - CIDR: 10.0.48.0/24, 10.0.49.0/24, 10.0.50.0/24 (256 IPs cada)
# - Ideais para Load Balancers, NAT Gateways, Bastion Hosts

# Public Subnet - Availability Zone A
# CIDR: 10.0.48.0/24 (10.0.48.1 - 10.0.48.254)
resource "aws_subnet" "public_subnet_1a" {
  vpc_id = aws_vpc.main.id

  # Bloco CIDR específico para recursos públicos na AZ-A
  cidr_block = "10.0.48.0/24"
  # Zona de disponibilidade dinâmica baseada na região
  availability_zone = format("%sa", var.region)

  tags = {
    Environment = var.environment,
    Name        = format("%s-public-subnet-1a", var.project_name)
  }
}

# Public Subnet - Availability Zone B
# CIDR: 10.0.49.0/24 (10.0.49.1 - 10.0.49.254)
resource "aws_subnet" "public_subnet_1b" {
  vpc_id = aws_vpc.main.id

  # Bloco CIDR específico para recursos públicos na AZ-B
  cidr_block = "10.0.49.0/24"
  # Zona de disponibilidade dinâmica baseada na região
  availability_zone = format("%sb", var.region)

  tags = {
    Environment = var.environment,
    Name        = format("%s-public-subnet-1b", var.project_name)
  }
}

# Public Subnet - Availability Zone C
# CIDR: 10.0.50.0/24 (10.0.50.1 - 10.0.50.254)
resource "aws_subnet" "public_subnet_1c" {
  vpc_id = aws_vpc.main.id

  # Bloco CIDR específico para recursos públicos na AZ-C
  cidr_block = "10.0.50.0/24"
  # Zona de disponibilidade dinâmica baseada na região
  availability_zone = format("%sc", var.region)

  tags = {
    Environment = var.environment,
    Name        = format("%s-public-subnet-1c", var.project_name)
  }

}

# =============================================================================
# ROUTING PARA SUBNETS PÚBLICAS
# =============================================================================

# Route Table para subnets públicas
# Todas as subnets públicas compartilham a mesma route table
# pois todas precisam do mesmo roteamento para a internet
resource "aws_route_table" "public_internet_access" {
  vpc_id = aws_vpc.main.id
  tags = {
    Environment = var.environment,
    Name        = format("%s-public", var.project_name)
  }
}

# Rota padrão para internet via Internet Gateway
# Todo tráfego (0.0.0.0/0) é direcionado para o Internet Gateway
resource "aws_route" "public_access" {
  route_table_id         = aws_route_table.public_internet_access.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Associação da Route Table com Public Subnet 1A
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_internet_access.id
}

# Associação da Route Table com Public Subnet 1B
resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_internet_access.id
}

# Associação da Route Table com Public Subnet 1C
resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_internet_access.id
}