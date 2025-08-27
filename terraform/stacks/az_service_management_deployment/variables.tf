variable "container_image" {
  type        = string
  description = "The container image name."
}

variable "namespace" {
  type        = string
  description = "The application namespace."
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
  description = "The container resources for the deployment."
}

variable "payments_api" {
  type        = string
  description = "The url to make the HTTP requests."
}

variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) > 0 && contains(["dev", "prod"], var.environment)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
  description = "The environment for the deployment."
}

variable "k8s_cluster_kube_config" {
  type = object({
    host                   = string
    cluster_ca_certificate = string
    client_certificate     = string
    client_key             = string
    username               = string
    password               = string
  })
  description = "The Kubernetes configuration file to deploy the application."
}
