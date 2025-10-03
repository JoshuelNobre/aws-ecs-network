# =============================================================================
# TERRAFORM BACKEND CONFIGURATION
# =============================================================================
#
# Configuração do backend S3 para armazenamento do state file remotamente.
# O backend S3 oferece:
# - Estado compartilhado entre membros da equipe
# - Locking automático com DynamoDB (quando configurado)
# - Versionamento e backup do state
# - Segurança através de criptografia
#
# Configuração deve ser feita via:
# - Arquivo backend.tfvars
# - Parâmetros na linha de comando
# - Variáveis de ambiente

terraform {
  backend "s3" {
    # Configuração será fornecida via backend.tfvars ou init -backend-config
    # Exemplo de parâmetros necessários:
    # bucket         = "meu-terraform-state-bucket"
    # key            = "ecs-network/terraform.tfstate"
    # region         = "us-east-1"
    # encrypt        = true
    # dynamodb_table = "terraform-state-lock" (opcional, para locking)
  }
}