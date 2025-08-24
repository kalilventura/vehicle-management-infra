variable "namespace" {
    type = string
    description = "The namespace to deploy the postgres chart to"
}

variable "database_name" {
  type = string
    description = "The postgres database"
}
