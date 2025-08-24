# vehicle-management-infra

This repository contains Terraform code for provisioning and managing infrastructure resources
for a microservices project.

## Description

This repository provides a framework for managing infrastructure using Terraform. It includes:

* **Modules:** Reusable modules for common infrastructure components
* **Variables:** Customizable variables to control infrastructure configurations.
* **Outputs:** Outputs to retrieve information about the provisioned infrastructure.

## Prerequisites

* **Terraform:** Install Terraform according to the instructions for your operating system. For more details, visit [Install Terraform](https://developer.hashicorp.com/terraform/install)
* **Azure CLI:** Install the Azure CLI according to the instructions for your operating system. For more details, visit [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* **Azure Service Principal:** Create an Azure Service Principal and assign the appropriate permissions. For more details, visit [Create an Azure service principal](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/kalilventura/vehicle-management-infra
   ```

2. **Navigate to the repository directory:**

   ```bash
   cd vehicle-management-infra
   ```

3. **Choose the environment to deploy:**

   ```bash
   cd terraform/environments/dev
   ```

4**Initialize Terraform:**

This command downloads the necessary providers (azurerm, kubernetes, etc.). You only need to do this once per directory.

   ```bash
   terraform init
   ```

5**Plan the deployment:**

This is a dry run that shows you exactly what resources Terraform will create. It's a great way to catch errors.

   ```bash
   terraform plan -out=dev.tfplan
   ```

6**Apply the infrastructure changes:**

This command will execute the plan and build your AKS cluster in Azure. It will ask for confirmation before proceeding.

   ```bash
   terraform apply "dev.tfplan"
   ```

7**(Optional) Destroy the infrastructure**

   ```bash
   terraform destroy
   ```

If you want to execute a target module, run:

   ```bash
   terraform apply -target=module.name
   ```

## Commands to improve the development and execution

To format the terraform configuration files to the standard style, run:

   ```bash
   terraform fmt -recursive
   ```

To validate the configuration files, run:

   ```bash
   terraform validate
   ```

## Contributing

Contributions are welcome! Please submit a pull request with a clear description of your changes.
