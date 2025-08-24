variable "resource_group_name" {
  description = "The name for the Azure Resource Group."
}

variable "location" {
  description = "The Azure region where resources will be created."
  default     = "East US"
}

variable "aks_cluster_name" {
  description = "The name for the AKS cluster."
}

variable "aks_default_node_pool_configuration" {
  type = object({
    name       = string
    node_count = number
    vm_size    = string
  })
  description = "The node pool configuration"
}

variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) > 0 && contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
  description = "The environment for the deployment."
}

variable "aks_tier" {
  type        = string
  default     = "Free"
  description = "The Azure Cluster tier."
}

variable "aks_cluster_dns_prefix" {
  type        = string
  default     = "soat"
  description = "The AKS cluster DNS Prefix."
}