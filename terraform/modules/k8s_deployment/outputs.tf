output "deployment_name" {
  value       = local.prefixed_name
  description = "The name of the deployment"
}

output "service_name" {
  value       = length(kubernetes_service.default) > 0 ? kubernetes_service.default[0].metadata[0].name : ""
  description = "The name of the service"
}

# output "ingress_url" {
#   value       = length(kubernetes_ingress_v1.default) > 0 ? kubernetes_ingress_v1.default[0].status[0].load_balancer[0].ingress[0].ip : ""
#   description = "The Load Balancer Ingress IP Address"
# }
