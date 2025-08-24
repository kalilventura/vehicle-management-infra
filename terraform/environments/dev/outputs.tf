output "aks_resource_group" {
  value       = module.aks_cluster.resource_group_name
  description = "The resource group name."
}

output "aks_cluster_name" {
  value       = module.aks_cluster.aks_cluster_name
  description = "The AKS Cluster name."
}
