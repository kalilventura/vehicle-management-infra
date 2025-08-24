variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) > 0 && contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
  description = "The environment for the deployment"
}
variable "namespace" {
  type        = string
  description = "The namespace for the in which the resources should be deployed"
}

variable "container_image" {
  type        = string
  description = "The container image for the deployment"
}

variable "container_name" {
  type        = string
  description = "The container name for the deployment"
}

variable "container_resources" {
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })
  description = "The container resources for the deployment"
}

variable "container_port" {
  type        = number
  default     = 8080
  description = "The container port for the deployment"
}

variable "secret_data" {
  type        = map(string)
  default     = {}
  description = "The secret data for the deployment"
}

variable "config_map_data" {
  type        = map(string)
  default     = {}
  description = "The config map data for the deployment"
}

variable "is_service_enabled" {
  type        = bool
  default     = false
  description = "Whether a service should be created for the deployment"
}

variable "is_ingress_enabled" {
  type        = bool
  default     = false
  description = "Whether an ingress should be created for the deployment"
}

variable "service_type" {
  type        = string
  default     = "ClusterIP"
  description = "The service type for the deployment"
}
