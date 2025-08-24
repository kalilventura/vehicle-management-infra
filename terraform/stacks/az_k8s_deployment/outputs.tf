output "resource_group_name" {
  value = module.resource_group.name
  description = "The deployed resource group name."
}

output "aks_cluster_name" {
  value = module.aks_cluster.aks_cluster_name
  description = "The AKS Cluster name."
}

output "aks_cluster_config" {
  sensitive = true
  value = module.aks_cluster.aks_cluster_config
  description = "The AKS cluster configuration."
}
