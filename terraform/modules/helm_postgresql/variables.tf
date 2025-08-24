variable "namespace" {
  type        = string
  description = "The namespace to deploy the postgres chart to."
}

variable "release_name" {
  type        = string
  default     = "database"
  description = "The release of the Bitnami PostgreSQL Helm chart to use."
}

variable "chart_version" {
  type        = string
  default     = "16.2.1"
  description = "The version of the Bitnami PostgreSQL Helm chart to use."
}

variable "database_name" {
  type        = string
  description = "The postgres database name."
}

variable "database_size" {
  type        = number
  default     = 1
  description = "The postgres database size. Default is 1Gi."
}
