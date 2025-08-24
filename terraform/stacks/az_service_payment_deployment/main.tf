module "app_namespace" {
  source    = "../../modules/k8s_namespace"
  namespace = var.namespace
}

module "app_database" {
  source        = "../../modules/helm_postgresql"
  namespace     = module.app_namespace.name
  database_name = "vehicle-payment"
}

module "app_deployment" {
  source    = "../../modules/k8s_deployment"
  namespace = module.app_namespace.name

  container_image    = var.container_image
  container_name     = "vehicle-payment-service"
  environment        = var.environment
  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {
    DB_HOST = module.app_database.service_internal_host
    DB_NAME = module.app_database.database_name
    DB_PORT = module.app_database.database_port
    DB_USER = module.app_database.normal_username
    DB_SSL  = "disable"
  }
  secret_data = {
    DB_PASSWORD = module.app_database.normal_password
  }

  container_resources = var.container_resources
}
