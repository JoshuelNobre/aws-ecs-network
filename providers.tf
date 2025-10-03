# =============================================================================
# PROVIDER CONFIGURATION
# =============================================================================
#
# Configuração do provider AWS para gerenciar recursos na nuvem.
# Define a região onde os recursos serão criados baseada na variável.
#
# Características:
# - Região configurável via variável
# - Usa credenciais do ambiente (AWS CLI, IAM Role, etc.)
# - Versão do provider definida em terraform block (se necessário)

provider "aws" {
  region = var.region
}