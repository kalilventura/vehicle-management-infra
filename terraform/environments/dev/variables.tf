variable "aks_cluster_name" {
  type        = string
  description = "Specifies the unique name for the Azure Kubernetes Service (AKS) cluster. Must be between 3 and 63 characters, and can only contain letters, numbers, and hyphens. Must start and end with a letter or number."

  validation {
    # Regex to ensure the name complies with Azure's naming conventions for AKS clusters.
    condition     = can(regex("^[a-zA-Z0-9](?:[a-zA-Z0-9-]{1,61}[a-zA-Z0-9])?$", var.aks_cluster_name))
    error_message = "Invalid AKS cluster name. It must be 3-63 characters long, start and end with a letter or number, and contain only letters, numbers, and hyphens."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group where the AKS cluster and related resources will be deployed. Must be between 1 and 90 characters."

  validation {
    # Regex to ensure the name complies with Azure's naming conventions for Resource Groups.
    condition     = length(var.resource_group_name) > 0 && length(var.resource_group_name) <= 90 && can(regex("^[-\\w\\._\\(\\)]+$", var.resource_group_name))
    error_message = "Invalid Resource Group name. It must be 1-90 characters long and can include alphanumeric characters, underscores, parentheses, hyphens, and periods."
  }
}

variable "environment" {
  type        = string
  description = "The deployment environment, used for resource tagging and conditional configurations. Must be either 'dev' for development or 'prod' for production."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
}

variable "dockerhub_username" {
  type        = string
  sensitive   = true
  description = "The Docker Hub username required to pull private container images. This will be used to create a Kubernetes image pull secret."

  validation {
    condition     = length(var.dockerhub_username) > 0
    error_message = "Docker Hub username cannot be empty."
  }
}

variable "vehicle_service_image_name" {
  type        = string
  description = "The name of the vehicle service's Docker image repository on Docker Hub (e.g., 'your-username/vehicle-service')."

  validation {
    condition     = length(var.vehicle_service_image_name) > 0
    error_message = "The vehicle service image name cannot be empty."
  }
}

variable "vehicle_service_image_tag" {
  type        = string
  description = "The specific tag or version of the vehicle service Docker image to deploy (e.g., 'latest', '1.2.0')."

  validation {
    condition     = length(var.vehicle_service_image_tag) > 0
    error_message = "The vehicle service image tag cannot be empty."
  }
}

variable "vehicle_payment_image_name" {
  type        = string
  description = "The name of the vehicle payment service's Docker image repository on Docker Hub (e.g., 'your-username/payment-service')."

  validation {
    condition     = length(var.vehicle_payment_image_name) > 0
    error_message = "The vehicle payment image name cannot be empty."
  }
}

variable "vehicle_payment_image_tag" {
  type        = string
  description = "The specific tag or version of the vehicle payment Docker image to deploy (e.g., 'latest', '1.2.0')."

  validation {
    condition     = length(var.vehicle_payment_image_tag) > 0
    error_message = "The vehicle payment image tag cannot be empty."
  }
}

variable "stripe_key" {
  type        = string
  sensitive   = true
  description = "The sensitive Stripe API key used by the payment service to process transactions. It will be stored as a Kubernetes secret."

  validation {
    # Stripe secret keys typically start with 'sk_'. This helps catch accidental input of the wrong key.
    condition     = substr(var.stripe_key, 0, 3) == "sk_"
    error_message = "Invalid Stripe key format. The key should start with 'sk_'."
  }
}

variable "stripe_webhook_key" {
  type        = string
  sensitive   = true
  description = "The sensitive Stripe webhook signing secret used to verify incoming webhook requests. It will be stored as a Kubernetes secret."

  validation {
    # Stripe webhook secrets typically start with 'whsec_'.
    condition     = substr(var.stripe_webhook_key, 0, 6) == "whsec_"
    error_message = "Invalid Stripe webhook key format. The key should start with 'whsec_'."
  }
}
