locals {
  app_port = module.app_deployment.service_port == 80 ? "" : ":${module.app_deployment.service_port}"
}

output "internal_host" {
  value       = "${module.app_deployment.service_name}.${module.app_namespace.name}${local.app_port}"
  description = "The host and port of the application to be used in the other applications."
}
