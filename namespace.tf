resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}
