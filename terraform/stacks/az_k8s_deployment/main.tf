module "resource_group" {
  source = "../../modules/az_resource_group"
  location = var.location
  resource_group_name = var.resource_group_name
}

module "aks_cluster" {
  source = "../../modules/az_kubernetes"

  resource_group_name = module.resource_group.name
  location            = var.location
  aks_cluster_name    = var.aks_cluster_name

  environment         = var.environment
  aks_default_node_pool_configuration = var.aks_default_node_pool_configuration
  aks_tier = var.aks_tier
  aks_cluster_dns_prefix = var.aks_cluster_dns_prefix
}
