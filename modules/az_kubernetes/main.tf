resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.vnet_subnet_id
  }

  network_profile {
    network_plugin = "azure" # Usando Azure CNI para melhor integração de rede
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Terraformed AKS"
  }
}