variable "aks_cluster_name" {
  type        = string
  description = "The name for the AKS cluster."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name."
}

variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) > 0 && contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
  description = "The environment for the deployment."
}

variable "dockerhub_username" {
  sensitive   = true
  type        = string
  description = "Docker Hub username."
}

variable "vehicle_service_image_name" {
  type        = string
  description = "The name of the Docker image."
}

variable "vehicle_service_image_tag" {
  type        = string
  description = "The tag for the Docker image to be deployed."
}

variable "vehicle_payment_image_name" {
  type        = string
  description = "The name of the Docker image."
}

variable "vehicle_payment_image_tag" {
  type        = string
  description = "The tag for the Docker image to be deployed."
}
