variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "prod", "test"], var.environment)
    error_message = "The environment must be one of 'dev', 'prod', or 'test'."
  }
  description = "Specifies the deployment environment. Must be either 'dev' or 'prod'. Used for resource naming and tagging."
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace where all resources will be created. Helps isolate applications within the cluster."
}

variable "container_name" {
  type        = string
  description = "A short name for the application container. This is used as a base for naming related Kubernetes resources (Deployment, Service, etc.)."
}

variable "container_image" {
  type        = string
  description = "The full Docker image for the application container, including the repository and tag (e.g., 'nginx:1.21.6' or 'myregistry.azurecr.io/myapp:latest')."
}

variable "container_port" {
  type        = number
  default     = 8080
  description = "The network port that the application inside the container is listening on for incoming traffic."
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
  description = "Defines the CPU and memory resources for the container. 'requests' are guaranteed resources, while 'limits' are the maximum the container can use."
}

variable "secret_data" {
  type        = map(string)
  default     = {}
  sensitive   = true
  description = "A map of sensitive key-value pairs (e.g., API keys, passwords) to be mounted as environment variables from a Kubernetes Secret."
}

variable "config_map_data" {
  type        = map(string)
  default     = {}
  description = "A map of non-sensitive configuration key-value pairs (e.g., feature flags, external URLs) to be mounted as environment variables from a Kubernetes ConfigMap."
}

variable "is_service_enabled" {
  type        = bool
  default     = true
  description = "If true, creates a Kubernetes Service to expose the application pods for network access."
}

variable "service_type" {
  type        = string
  default     = "LoadBalancer" # Good default for testing on AKS
  description = "Determines how the Service is exposed. Common values: 'ClusterIP' (internal only), 'NodePort' (on each node's IP), 'LoadBalancer' (cloud provider public IP)."
}

variable "is_ingress_enabled" {
  type        = bool
  default     = false
  description = "If true, creates a Kubernetes Ingress resource to manage external HTTP/S access to the Service."
}

variable "ingress_hostname" {
  type        = string
  default     = null
  description = "The fully qualified domain name (e.g., 'api.myapp.com') that the Ingress will listen on. Required if 'is_ingress_enabled' is true."
}
