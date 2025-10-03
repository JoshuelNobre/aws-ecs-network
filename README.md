# AWS ECS Network Infrastructure

Esta infraestrutura Terraform cria uma arquitetura de rede robusta e escalável na AWS, otimizada para workloads ECS com foco em segurança, alta disponibilidade e boas práticas.

## 📋 Índice

- [Visão Geral](#-visão-geral)
- [Arquitetura](#-arquitetura)
- [Recursos Criados](#-recursos-criados)
- [Pré-requisitos](#-pré-requisitos)
- [Como Usar](#-como-usar)
- [Configuração de Ambientes](#-configuração-de-ambientes)
- [Monitoramento](#-monitoramento)
- [Segurança](#-segurança)
- [Custos](#-custos)
- [Contribuição](#-contribuição)

## 🎯 Visão Geral

Este projeto implementa uma VPC com arquitetura de 3 camadas:

- **Camada Pública**: Load Balancers, NAT Gateways
- **Camada Privada**: Aplicações ECS, EC2 instances
- **Camada de Dados**: RDS, ElastiCache, bancos de dados

### Características Principais

- ✅ **Multi-AZ**: Distribuído em 3 Availability Zones
- ✅ **Segurança**: Isolamento por camadas
- ✅ **Escalabilidade**: Suporte a milhares de containers
- ✅ **Alta Disponibilidade**: NAT Gateways redundantes
- ✅ **Observabilidade**: Integração com Parameter Store
- ✅ **Reutilização**: Recursos compartilháveis entre projetos

## 🏗️ Arquitetura

### Estrutura de Rede

```
VPC: 10.0.0.0/16 (65.536 IPs)
├── Public Subnets (768 IPs total)
│   ├── 10.0.48.0/24 (AZ-A) - ALB, NAT Gateway
│   ├── 10.0.49.0/24 (AZ-B) - ALB, NAT Gateway  
│   └── 10.0.50.0/24 (AZ-C) - ALB, NAT Gateway
├── Private Subnets (12.288 IPs total)
│   ├── 10.0.0.0/20  (AZ-A) - ECS Tasks, EC2
│   ├── 10.0.16.0/20 (AZ-B) - ECS Tasks, EC2
│   └── 10.0.32.0/20 (AZ-C) - ECS Tasks, EC2
└── Database Subnets (768 IPs total)
    ├── 10.0.51.0/24 (AZ-A) - RDS, ElastiCache
    ├── 10.0.52.0/24 (AZ-B) - RDS, ElastiCache
    └── 10.0.53.0/24 (AZ-C) - RDS, ElastiCache
```

Para detalhes completos da arquitetura, consulte [ARCHITECTURE.md](ARCHITECTURE.md).

## 📦 Recursos Criados

### Infraestrutura de Rede
- **1 VPC** com DNS habilitado
- **9 Subnets** distribuídas em 3 AZs
- **1 Internet Gateway** para acesso público
- **3 NAT Gateways** com Elastic IPs
- **4 Route Tables** com roteamento otimizado

### Observabilidade
- **10 Parâmetros SSM** para compartilhamento de recursos
- **Outputs** para integração com outros projetos
- **Tags padronizadas** em todos os recursos

## 🔧 Pré-requisitos

### Software Necessário
```bash
# Terraform >= 1.0
terraform --version

# AWS CLI v2
aws --version

# Configuração AWS
aws configure
```

### Permissões AWS Necessárias
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "ssm:*"
      ],
      "Resource": "*"
    }
  ]
}
```

## 🚀 Como Usar

### 1. Clone o Repositório
```bash
git clone https://github.com/JoshuelNobre/aws-ecs-network.git
cd aws-ecs-network
```

### 2. Configure as Variáveis
```bash
# Copie e edite o arquivo de variáveis
cp environment/dev/terraform.tfvars.example environment/dev/terraform.tfvars

# Edite as variáveis conforme necessário
nano environment/dev/terraform.tfvars
```

### 3. Configure o Backend (Opcional)
```bash
# Para usar backend S3, configure o arquivo
nano environment/dev/backend.tfvars

# Conteúdo exemplo:
bucket         = "meu-terraform-state-bucket"
key            = "aws-ecs-network/dev/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-state-lock"
```

### 4. Deploy da Infraestrutura
```bash
# Inicializar Terraform
terraform init -backend-config=environment/dev/backend.tfvars

# Revisar o plano
terraform plan -var-file=environment/dev/terraform.tfvars

# Aplicar as mudanças
terraform apply -var-file=environment/dev/terraform.tfvars
```

### 5. Verificar Recursos Criados
```bash
# Listar outputs
terraform output

# Verificar parâmetros no SSM
aws ssm get-parameters-by-path \
  --path "/seu-projeto/vpc" \
  --recursive
```

## ⚙️ Configuração de Ambientes

### Arquivo terraform.tfvars
```hcl
# environment/dev/terraform.tfvars
project_name = "meu-projeto"
region       = "us-east-1"
environment  = "dev"
```

### Arquivo backend.tfvars (Opcional)
```hcl
# environment/dev/backend.tfvars
bucket         = "terraform-state-bucket-dev"
key            = "aws-ecs-network/dev/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-state-lock"
```

## 📊 Monitoramento

### Métricas Importantes
- **NAT Gateway Data Processing**: Custos de transferência
- **Elastic IP Utilization**: IPs não utilizados
- **VPC Flow Logs**: Tráfego de rede (se habilitado)

### CloudWatch Dashboards
```bash
# Criar dashboard para monitoramento
aws cloudwatch put-dashboard \
  --dashboard-name "ECS-Network-Monitoring" \
  --dashboard-body file://monitoring/dashboard.json
```

## 🔒 Segurança

### Princípios Implementados
1. **Isolamento por Camadas**: Separação clara de responsabilidades
2. **Menor Privilégio**: Database subnets sem acesso à internet
3. **Defesa em Profundidade**: Múltiplas camadas de segurança
4. **Auditabilidade**: Logs e monitoramento abrangentes

### Próximos Passos de Segurança
- [ ] Implementar Security Groups específicos
- [ ] Configurar Network ACLs restritivas
- [ ] Habilitar VPC Flow Logs
- [ ] Implementar AWS WAF nos ALBs
- [ ] Configurar GuardDuty para detecção de ameaças

## 💰 Custos

### Estimativa Mensal (us-east-1)
| Recurso | Quantidade | Custo Mensal |
|---------|------------|--------------|
| NAT Gateways | 3 | ~$135.00 |
| Elastic IPs | 3 | $0.00* |
| Data Transfer | Variável | ~$20-100 |
| **Total Estimado** | | **~$155-235** |

_*Gratuitos enquanto anexados aos NAT Gateways_

### Otimização para Dev/Test
Para ambientes não-produtivos, considere usar apenas 1 NAT Gateway para reduzir custos para ~$45/mês.

## 🤝 Contribuição

### Como Contribuir
1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Add nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

### Padrões de Código
- Use comentários descritivos em português
- Siga as convenções de naming do Terraform
- Adicione validações nas variáveis
- Inclua tags padronizadas em todos os recursos

## 📚 Recursos Adicionais

- [AWS VPC Best Practices](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-best-practices.html)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [ECS Networking Documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html)

## 🆘 Suporte

Para problemas ou dúvidas:
1. Verifique a [documentação de arquitetura](ARCHITECTURE.md)
2. Consulte as [issues do projeto](https://github.com/JoshuelNobre/aws-ecs-network/issues)
3. Abra uma nova issue se necessário

---

**Desenvolvido com ❤️ para a comunidade DevOps**