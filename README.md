# Vehicle Management Infrastructure

This repository contains the infrastructure as code (IaC) for the Vehicle Management System using Terraform and Terragrunt.

## 🏗️ Architecture Overview

The infrastructure is organized using a modular approach with Terragrunt for configuration management:

```
├── infra/
│   ├── modules/            # Reusable Terraform modules
│   │   ├── helm_postgres/  
│   │   ├── k8s_deployment/ 
│   │   └── k8s_namespace/
│   └── environments/       # Environment-specific configurations
│       ├── dev/            # Development environment
│       ├── staging/        # Staging environment
│       └── prod/           # Production environment
├── terragrunt.hcl          # Root Terragrunt configuration
└── .terragrunt-cache/      # Terragrunt cache (auto-generated)
```

## 🚀 Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) >= 0.45
- AWS CLI configured with appropriate credentials
- Docker (for local development)

### Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd vehicle-management-infra
   ```

2. **Install dependencies:**
   Terragrunt
   ```bash
   TG_VERSION=$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | grep tag_name | cut -d '"' -f 4)

   wget https://github.com/gruntwork-io/terragrunt/releases/download/$TG_VERSION/terragrunt_linux_amd64

   sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

   sudo chmod +x /usr/local/bin/terragrunt

   terragrunt --version
   ```
3. **Configure AWS credentials:**
   ```bash
   aws configure
   ```

### Usage

#### Deploy to Development Environment

```bash
cd terraform/environments/dev
terragrunt plan
terragrunt apply
```

#### Deploy to Staging Environment

```bash
cd terraform/environments/staging
terragrunt plan
terragrunt apply
```

#### Deploy to Production Environment

```bash
cd terraform/environments/prod
terragrunt plan
terragrunt apply
```

#### Destroy Infrastructure

```bash
cd terraform/environments/<environment>
terragrunt destroy
```

## 📁 Directory Structure

### Modules

- **VPC Module**: Creates VPC, subnets, route tables, and internet gateway
- **EC2 Module**: Deploys EC2 instances with auto-scaling groups
- **RDS Module**: Sets up RDS database instances
- **ALB Module**: Configures Application Load Balancer
- **Security Module**: Manages security groups and IAM roles

### Environments

Each environment has its own configuration with environment-specific variables:
- **dev**: Development environment with minimal resources
- **staging**: Staging environment mirroring production
- **prod**: Production environment with high availability

## 🔧 Configuration

### Environment Variables

Create a `.env` file in each environment directory:

```bash
# terraform/environments/dev/.env
AWS_REGION=us-west-2
ENVIRONMENT=dev
INSTANCE_TYPE=t3.micro
DB_INSTANCE_CLASS=db.t3.micro
```

### Terragrunt Configuration

The root `terragrunt.hcl` file contains common configuration shared across all environments.

## 🚨 Security Considerations

- All sensitive data should be stored in AWS Secrets Manager or Parameter Store
- Use IAM roles with least privilege principle
- Enable CloudTrail logging for audit purposes
- Regular security updates and vulnerability scanning

## 📊 Monitoring and Logging

- CloudWatch for metrics and alarms
- CloudTrail for API logging
- VPC Flow Logs for network monitoring
- RDS Performance Insights for database monitoring

## 🔄 CI/CD Integration

The infrastructure can be integrated with CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
name: Deploy Infrastructure
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
      - name: Deploy to Dev
        run: |
          cd terraform/environments/dev
          terragrunt apply -auto-approve
```

## 🆘 Troubleshooting

### Common Issues

1. **Terragrunt Cache Issues**
   ```bash
   terragrunt clean
   ```

2. **State Lock Issues**
   ```bash
   terragrunt force-unlock <lock-id>
   ```

3. **Module Version Conflicts**
   ```bash
   terragrunt get --update
   ```

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terragrunt Documentation](https://terragrunt.gruntwork.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.