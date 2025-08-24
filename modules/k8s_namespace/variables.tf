variable "namespace" {
  type = string
  validation {
    condition     = length(var.namespace) > 0
    error_message = "The namespace must not be empty."
  }
  description = "The namespace for the in which the resources should be deployed"
}
