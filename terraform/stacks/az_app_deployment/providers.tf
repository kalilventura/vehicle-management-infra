terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.35.1"
    }
  }
}

provider "kubernetes" {
  host                   = var.k8s_cluster_kube_config.host
  client_certificate     = base64decode(var.k8s_cluster_kube_config.client_certificate)
  cluster_ca_certificate = base64decode(var.k8s_cluster_kube_config.cluster_ca_certificate)
  client_key             = base64decode(var.k8s_cluster_kube_config.client_key)
  username = var.k8s_cluster_kube_config.username
  password = var.k8s_cluster_kube_config.password
}
