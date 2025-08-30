module "app_namespace" {
  source    = "../../modules/k8s_namespace"
  namespace = var.namespace
}

module "app_database" {
  source        = "../../modules/helm_postgresql"
  namespace     = module.app_namespace.name
  database_name = "vehicle-management"
}

module "app_deployment" {
  source    = "../../modules/k8s_deployment"
  namespace = module.app_namespace.name

  container_image = var.container_image
  container_name  = "vehicle-management-service"
  container_port  = 8080
  environment     = var.environment
  service_type    = "LoadBalancer"

  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {
    DB_HOST = module.app_database.service_internal_host
    DB_NAME = module.app_database.database_name
    DB_PORT = module.app_database.database_port
    DB_USER = module.app_database.normal_username
    DB_SSL  = "disable"

    PAYMENTS_API = var.payments_api
    APP_PORT     = 8080
  }
  secret_data = {
    DB_PASSWORD = module.app_database.normal_password
  }
  container_resources = var.container_resources
}
