output "service_name" {
  value       = length(kubernetes_service.default) > 0 ? kubernetes_service.default[0].metadata[0].name : ""
  description = "The name of the service."
}

output "service_port" {
  value = length(kubernetes_service.default) > 0 ? (
    length(kubernetes_service.default[0].spec[0].port) > 0 ? (
      kubernetes_service.default[0].spec[0].port[0].port
    ) : 0
  ) : 0
  description = "The port of the service."
}

# output "ingress_url" {
#   value       = length(kubernetes_ingress_v1.default) > 0 ? kubernetes_ingress_v1.default[0].status[0].load_balancer[0].ingress[0].ip : ""
#   description = "The Load Balancer Ingress IP Address"
# }
