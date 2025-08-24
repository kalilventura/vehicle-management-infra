terraform {
    required_version = ">= 1.9.3"
    required_providers {
        helm = {
            source = "hashicorp/helm"
            version = ">= 2.35.1"
        }
        random = {
            source = "hashicorp/random"
            version = ">= 3.5.1"
        }
    }
}

resource "random_password" "admin_password" {
    length = 32
    special = true
    override_special = "_-=+.@"
}

resource "random_uuid" "normal_username" {}

resource "random_password" "normal_password" {
    length = 32
    special = true
    override_special = "_-=+.@"
}

resource "helm_release" "default" {
    name = "postgres"
    chart = "postgresql"
    repository = "https://charts.bitnami.com/bitnami"
    version = "16.2.1"

    timeout = 350 # 5 minutes
    
    namespace = var.namespace
    create_namespace = true

    set {
        name = "auth.username"
        value = random_uuid.normal_username.result
    }
    
    set {
        name = "auth.password"
        value = random_password.normal_password.result
    }

    set {
        name = "auth.postgresPassword"
        value = random_password.admin_password.result
    }

    set {
      name = "auth.database"
      value = var.database_name
    }
}
