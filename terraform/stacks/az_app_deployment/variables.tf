variable "container_image" {
  type        = string
}

variable "container_name" {
  type        = string
}

variable "namespace" {
  type        = string
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
    host = string
    cluster_ca_certificate = string
    client_certificate = string
    client_key = string
    username = string
    password = string
  })
  description = "The Kubernetes configuration file to deploy the application."
}
