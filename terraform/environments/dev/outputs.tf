output "aks_resource_group" {
  value       = module.aks_cluster.resource_group_name
  description = "The resource group name."
}

output "aks_cluster_name" {
  value       = module.aks_cluster.aks_cluster_name
  description = "The AKS Cluster name."
}

output "vehicle_management_service" {
  value       = module.vehicle_management_service.vehicle_management_service_internal_host
  description = "The host and port of the application to be used in the other applications."
}

output "vehicle_payment_service" {
  value       = module.vehicle_payment_service.vehicle_payment_service_internal_host
  description = "The host and port of the application to be used in the other applications."
}
