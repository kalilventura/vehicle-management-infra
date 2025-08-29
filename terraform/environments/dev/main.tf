module "aks_cluster" {
  source = "../../stacks/az_k8s_deployment"

  resource_group_name = var.resource_group_name
  aks_cluster_name    = var.aks_cluster_name
  environment         = var.environment

  aks_default_node_pool_configuration = {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = 2
  }
}

module "vehicle_payment_service" {
  source = "../../stacks/az_service_payment_deployment"

  container_image    = "${var.dockerhub_username}/${var.vehicle_payment_image_name}:${var.vehicle_payment_image_tag}"
  environment        = var.environment
  namespace          = "vehicle-payment"
  stripe_key         = var.stripe_key
  stripe_webhook_key = var.stripe_webhook_key

  k8s_cluster_kube_config = module.aks_cluster.aks_cluster_config

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

module "vehicle_management_service" {
  source = "../../stacks/az_service_management_deployment"

  container_image         = "${var.dockerhub_username}/${var.vehicle_service_image_name}:${var.vehicle_service_image_tag}"
  environment             = var.environment
  namespace               = "vehicle-management"
  payments_api            = module.vehicle_payment_service.internal_host
  k8s_cluster_kube_config = module.aks_cluster.aks_cluster_config

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
