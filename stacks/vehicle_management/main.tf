module "namespace" {
    source = "../../modules/k8s_namespace"
    namespace = "vehicle-management"
}

locals {
  db_name = "vehicle_management"
}

module "database" {
    source = "../../modules/helm_postgres"

    database_name = local.db_name
    namespace = module.namespace.name
}

module "vehicle_payment_api" {
  source = "../../modules/k8s_deployment"

  container_image    = var.vehicle_management_http_image
  container_name     = "vehicle-payment-http"
  environment        = var.environment
  namespace          = module.namespace.name
  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {}

  secret_data = {
    DB_HOST = module.database.db_host
    DB_USER = module.database.normal_username
    DB_PASS = module.database.normal_password
    DB_PORT = module.database.db_port
  }

  container_resources = {
    requests = {
      cpu    = "250m"
      memory = "64Mi"
    }
    limits = {
      cpu    = "1000m"
      memory = "512Mi"
    }
  }
}