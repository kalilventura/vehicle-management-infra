terraform {
  required_version = ">= 1.9.3"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.35.1"
    }
  }
}

locals {
  app_tier      = "backend"
  prefixed_name = "${var.environment}-${var.container_name}"
}

resource "kubernetes_secret" "default" {
  count = length(keys(var.secret_data)) > 0 ? 1 : 0

  metadata {
    name      = "${local.prefixed_name}-secret"
    namespace = var.namespace
  }
  data = var.secret_data
}

resource "kubernetes_config_map" "default" {
  count = length(keys(var.config_map_data)) > 0 ? 1 : 0

  metadata {
    name      = "${local.prefixed_name}-config-map"
    namespace = var.namespace
  }
  data = var.config_map_data
}

resource "kubernetes_deployment" "default" {
  metadata {
    name      = local.prefixed_name
    namespace = var.namespace
    labels = {
      name        = local.prefixed_name
      environment = var.environment
      tier        = local.app_tier
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name        = local.prefixed_name
        environment = var.environment
        tier        = local.app_tier
      }
    }

    template {
      metadata {
        labels = {
          name                           = local.prefixed_name
          environment                    = var.environment
          tier                           = local.app_tier
          "app.kubernetes.io/created-by" = "SOAT-46"
        }
      }
      spec {
        container {
          name              = local.prefixed_name
          image             = var.container_image
          image_pull_policy = "Always"

          resources {
            requests = var.container_resources.requests
            limits   = var.container_resources.limits
          }

          port {
            container_port = var.container_port
          }

          dynamic "env_from" {
            for_each = length(kubernetes_secret.default) > 0 ? [1] : []
            content {
              dynamic "secret_ref" {
                for_each = length(kubernetes_secret.default) > 0 ? [1] : []
                content {
                  name = kubernetes_secret.default[0].metadata[0].name
                }
              }
            }
          }

          dynamic "env_from" {
            for_each = length(kubernetes_config_map.default) > 0 ? [1] : []
            content {
              dynamic "secret_ref" {
                for_each = length(kubernetes_config_map.default) > 0 ? [1] : []
                content {
                  name = kubernetes_config_map.default[0].metadata[0].name
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "default" {
  count = var.is_service_enabled ? 1 : 0

  metadata {
    name      = local.prefixed_name
    namespace = var.namespace
  }

  spec {
    type = var.service_type
    selector = {
      name        = local.prefixed_name
      environment = var.environment
      tier        = local.app_tier
    }
    port {
      name        = "http"
      port        = 80
      target_port = var.container_port
    }
  }

  depends_on = [
    kubernetes_deployment.default,
  ]
}

resource "kubernetes_ingress_v1" "default" {
  count = var.is_ingress_enabled ? 1 : 0

  metadata {
    name      = "${local.prefixed_name}-http-ingress"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/ingress.class"                = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    rule {
      http {
        path {
          # Traffic to / will be forwarded to your service
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = local.prefixed_name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_deployment.default,
    kubernetes_service.default,
  ]
}
