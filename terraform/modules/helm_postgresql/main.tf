resource "random_password" "admin_password" {
  length           = 32
  special          = true
  override_special = "_-=+.@"
}

resource "random_uuid" "normal_username" {}

resource "random_password" "normal_password" {
  length           = 32
  special          = true
  override_special = "_-=+.@"
}

locals {
  chart_name = "postgresql"
}

resource "helm_release" "default" {
  name       = var.release_name
  chart      = local.chart_name
  repository = "https://charts.bitnami.com/bitnami"
  version    = var.chart_version
  timeout    = 350 # 5 minutes

  namespace        = var.namespace
  create_namespace = true

  set = [
    {
      name  = "auth.username"
      value = random_uuid.normal_username.result
    },
    {
      name  = "auth.password"
      value = random_password.normal_password.result
    },
    {
      name  = "auth.postgresPassword"
      value = random_password.admin_password.result
    },
    {
      name  = "auth.database"
      value = var.database_name
    },
    {
      name  = "primary.persistence.size"
      value = "${var.database_size}Gi"
    }
  ]
}
