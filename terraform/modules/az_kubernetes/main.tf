resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.environment}-aks-${var.aks_cluster_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_cluster_dns_prefix

  default_node_pool {
    name       = var.aks_default_node_pool_configuration.name
    node_count = var.aks_default_node_pool_configuration.node_count
    vm_size    = var.aks_default_node_pool_configuration.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = var.aks_tier

  tags = {
    Environment = var.environment
  }
}
