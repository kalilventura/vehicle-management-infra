module "app_namespace" {
  source    = "../../modules/k8s_namespace"
  namespace = var.namespace
}

module "app_deployment" {
  source    = "../../modules/k8s_deployment"
  namespace = module.app_namespace.name

  container_image = var.container_image
  container_name = var.container_name
  environment = var.environment
  is_ingress_enabled = false
  is_service_enabled = true

  config_map_data = {}
  secret_data = {}

  container_resources = var.container_resources
}
