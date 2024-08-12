locals {
  default_labels = {
    "istio.io/dataplane-mode" = "ambient"
  }
  final_labels = merge(local.default_labels, var.labels)
}

resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name        = var.name
    labels      = local.final_labels
    annotations = var.annotations
  }
}
