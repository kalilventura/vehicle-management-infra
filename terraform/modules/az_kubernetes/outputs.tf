output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
  description = "The AKS Cluster name."
}

output "aks_cluster_config" {
  sensitive   = true
  value       = azurerm_kubernetes_cluster.default.kube_config[0]
  description = "The AKS cluster configuration."
}
