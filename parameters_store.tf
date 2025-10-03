# =============================================================================
# AWS SYSTEMS MANAGER PARAMETER STORE
# =============================================================================
#
# Armazena IDs dos recursos de rede no Parameter Store para que outros
# projetos e stacks Terraform possam reutilizar essa infraestrutura.
#
# Benefícios:
# - Desacoplamento entre projetos
# - Reutilização de recursos de rede
# - Versionamento automático de parâmetros
# - Acesso via CLI, SDK ou Terraform
#
# Padrão de nomenclatura: /<project_name>/vpc/<resource_type>

# =============================================================================
# VPC PARAMETERS
# =============================================================================

# Armazena o ID da VPC principal
# Usado por outros projetos que precisam referenciar a VPC
resource "aws_ssm_parameter" "vpc" {
  name  = format("/%s/vpc/vpc_id", var.project_name)
  type  = "String"
  value = aws_vpc.main.id
}

# =============================================================================
# PRIVATE SUBNETS PARAMETERS
# =============================================================================

# ID da Private Subnet - AZ A
resource "aws_ssm_parameter" "private_1a" {
  name  = format("/%s/vpc/private_subnet_1a", var.project_name)
  type  = "String"
  value = aws_subnet.private_subnet_1a.id
}

# ID da Private Subnet - AZ B
resource "aws_ssm_parameter" "private_1b" {
  name  = format("/%s/vpc/private_subnet_1b", var.project_name)
  type  = "String"
  value = aws_subnet.private_subnet_1b.id
}

# ID da Private Subnet - AZ C
resource "aws_ssm_parameter" "private_1c" {
  name  = format("/%s/vpc/private_subnet_1c", var.project_name)
  type  = "String"
  value = aws_subnet.private_subnet_1c.id
}

# =============================================================================
# PUBLIC SUBNETS PARAMETERS
# =============================================================================

# ID da Public Subnet - AZ A
resource "aws_ssm_parameter" "public_1a" {
  name  = format("/%s/vpc/public_subnet_1a", var.project_name)
  type  = "String"
  value = aws_subnet.public_subnet_1a.id
}

# ID da Public Subnet - AZ B
resource "aws_ssm_parameter" "public_1b" {
  name  = format("/%s/vpc/public_subnet_1b", var.project_name)
  type  = "String"
  value = aws_subnet.public_subnet_1b.id
}

# ID da Public Subnet - AZ C
resource "aws_ssm_parameter" "public_1c" {
  name  = format("/%s/vpc/public_subnet_1c", var.project_name)
  type  = "String"
  value = aws_subnet.public_subnet_1c.id
}

# =============================================================================
# DATABASE SUBNETS PARAMETERS
# =============================================================================

# ID da Database Subnet - AZ A
resource "aws_ssm_parameter" "databases_1a" {
  name  = format("/%s/vpc/databases_subnet_1a", var.project_name)
  type  = "String"
  value = aws_subnet.databases_subnet_1a.id
}

# ID da Database Subnet - AZ B
resource "aws_ssm_parameter" "databases_1b" {
  name  = format("/%s/vpc/databases_subnet_1b", var.project_name)
  type  = "String"
  value = aws_subnet.databases_subnet_1b.id
}

# ID da Database Subnet - AZ C
resource "aws_ssm_parameter" "databases_1c" {
  name  = format("/%s/vpc/databases_subnet_1c", var.project_name)
  type  = "String"
  value = aws_subnet.databases_subnet_1c.id
}