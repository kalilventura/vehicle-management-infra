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
