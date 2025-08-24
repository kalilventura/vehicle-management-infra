terraform {
  required_version = ">= 1.9.3"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.35.1"
    }
  }
}

resource "kubernetes_namespace" "default" {
  metadata {
    name = var.namespace
  }
}
