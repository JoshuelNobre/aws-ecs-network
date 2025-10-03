# =============================================================================
# VARIÁVEIS DE CONFIGURAÇÃO GERAL
# =============================================================================
#
# Este arquivo define as variáveis necessárias para a infraestrutura.
# Mantém a configuração simples e direta para facilitar o uso.

# Nome do projeto
# Usado como prefixo para nomeação de recursos e organização
variable "project_name" {
  description = "Nome do projeto que será usado como prefixo para todos os recursos"
  type        = string
}

# Região AWS onde os recursos serão criados
# Define a localização geográfica da infraestrutura
variable "region" {
  description = "Região AWS onde a infraestrutura será provisionada"
  type        = string
}

# Ambiente de deployment (dev, stg, prd)
# Usado para segregação de recursos e aplicação de políticas específicas
variable "environment" {
  description = "Ambiente de deployment (dev, stg, prd)"
  type        = string
}