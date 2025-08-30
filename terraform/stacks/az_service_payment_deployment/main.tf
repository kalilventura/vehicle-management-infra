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

  container_image = var.container_image
  container_name  = "vehicle-payment-service"
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

    APP_PORT = 8080
  }
  secret_data = {
    DB_PASSWORD        = module.app_database.normal_password
    STRIPE_KEY         = var.stripe_key
    STRIPE_WEBHOOK_KEY = var.stripe_webhook_key
  }
  container_resources = var.container_resources
}
