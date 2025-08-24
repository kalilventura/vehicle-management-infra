variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resources."
  type        = string
}

variable "aks_cluster_dns_prefix" {
  description = "The AKS cluster DNS Prefix."
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) > 0 && contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
  description = "The environment for the deployment"
}

variable "aks_default_node_pool_configuration" {
  type = object({
    name = string
    node_count = number
    vm_size = string
  })
  description = "The node pool configuration"
}

variable "aks_tier" {
  type = string
  description = "The Azure Cluster tier."
}
