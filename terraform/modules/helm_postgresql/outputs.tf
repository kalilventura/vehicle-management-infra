output "service_internal_host" {
  value       = "${var.release_name}-${local.chart_name}"
  description = "The name of the postgres service to be used in the other applications."
}

output "database_name" {
  value       = var.database_name
  description = "The name of the postgres database created."
}

output "database_port" {
  value       = 5432
  description = "The port of the postgres database created."
}

output "normal_username" {
  value       = random_uuid.normal_username.result
  description = "The name of the custom postgres user."
}

output "normal_password" {
  sensitive   = true
  value       = random_password.normal_password.result
  description = "Password for the custom postgres user."
}
