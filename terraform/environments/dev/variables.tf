variable "aks_cluster_name" {
  type        = string
  description = "The name for the AKS cluster."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) > 0 && contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
  description = "The environment for the deployment."
}
