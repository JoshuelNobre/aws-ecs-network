# =============================================================================
# VPC PRINCIPAL
# =============================================================================
#
# Configuração da VPC principal que será usada para hospedar todos os recursos.
# CIDR: 10.0.0.0/16 - 65.536 endereços IP disponíveis
# 
# Recursos habilitados:
# - DNS Support: Permite resolução de DNS dentro da VPC
# - DNS Hostnames: Atribui nomes DNS públicos para instâncias com IPs públicos
#
# Esta VPC será a base para toda a infraestrutura de rede do projeto.

resource "aws_vpc" "main" {
  # Bloco CIDR da VPC - 10.0.0.0/16 fornece ~65k IPs
  cidr_block = "10.0.0.0/16"

  # Habilita suporte a DNS interno da AWS
  # Necessário para comunicação entre recursos
  enable_dns_support = true

  # Habilita nomes de host DNS para instâncias na VPC
  # Permite que instâncias tenham nomes DNS resolvíveis
  enable_dns_hostnames = true

  tags = {
    Environment = var.environment,
    Name        = var.project_name
  }
}