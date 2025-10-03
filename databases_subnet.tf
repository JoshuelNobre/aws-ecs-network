# =============================================================================
# DATABASE SUBNETS
# =============================================================================
#
# Configuração de subnets privadas dedicadas para bancos de dados.
# Essas subnets são isoladas e não possuem acesso direto à internet,
# garantindo maior segurança para os dados.
#
# Características:
# - Sem acesso direto à internet
# - Distribuídas em 3 AZs para alta disponibilidade
# - CIDR: 10.0.51.0/24, 10.0.52.0/24, 10.0.53.0/24 (256 IPs cada)
# - Ideais para RDS, ElastiCache, DocumentDB, etc.

# Database Subnet - Availability Zone A
# CIDR: 10.0.51.0/24 (10.0.51.1 - 10.0.51.254)
resource "aws_subnet" "databases_subnet_1a" {
  vpc_id = aws_vpc.main.id

  # Bloco CIDR específico para bancos de dados na AZ-A
  cidr_block = "10.0.51.0/24"
  # Zona de disponibilidade dinâmica baseada na região
  availability_zone = format("%sa", var.region)

  tags = {
    Environment = var.environment,
    Name        = format("%s-databases-subnet-1a", var.project_name)
  }
}

# Database Subnet - Availability Zone B
# CIDR: 10.0.52.0/24 (10.0.52.1 - 10.0.52.254)
resource "aws_subnet" "databases_subnet_1b" {
  vpc_id = aws_vpc.main.id

  # Bloco CIDR específico para bancos de dados na AZ-B
  cidr_block = "10.0.52.0/24"
  # Zona de disponibilidade dinâmica baseada na região
  availability_zone = format("%sb", var.region)

  tags = {
    Environment = var.environment,
    Name        = format("%s-databases-subnet-1b", var.project_name)
  }
}

# Database Subnet - Availability Zone C
# CIDR: 10.0.53.0/24 (10.0.53.1 - 10.0.53.254)
resource "aws_subnet" "databases_subnet_1c" {
  vpc_id = aws_vpc.main.id

  # Bloco CIDR específico para bancos de dados na AZ-C
  cidr_block = "10.0.53.0/24"
  # Zona de disponibilidade dinâmica baseada na região
  availability_zone = format("%sc", var.region)

  tags = {
    Environment = var.environment,
    Name        = format("%s-databases-subnet-1c", var.project_name)
  }
}