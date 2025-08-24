terraform {
  required_version = ">= 1.9.3"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
}
