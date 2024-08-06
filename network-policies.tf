resource "kubernetes_network_policy_v1" "default_deny_all" {
  metadata {
    name      = "default-deny-all"
    namespace = kubernetes_namespace_v1.namespace.metadata.0.name
  }

  spec {
    policy_types = ["Ingress"]
    pod_selector {
      match_labels = {}
    }
  }
}

resource "kubernetes_network_policy_v1" "allow_from_same_namespace" {
  metadata {
    name      = "allow-from-same-namespace"
    namespace = kubernetes_namespace_v1.namespace.metadata.0.name
  }

  spec {
    policy_types = ["Ingress"]
    pod_selector {}

    ingress {
      from {
        pod_selector {}
      }
    }
  }
}

resource "kubernetes_network_policy_v1" "allow_ingress_from_ingress" {
  metadata {
    name      = "allow-ingress"
    namespace = kubernetes_namespace_v1.namespace.metadata.0.name
  }

  spec {
    policy_types = ["Ingress"]
    pod_selector {}

    ingress {
      from {
        namespace_selector {
          match_expressions {
            key      = "kubernetes.io/metadata.name"
            operator = "In"
            values   = ["ingress"]
          }
        }
      }
    }
  }
}

resource "kubernetes_network_policy_v1" "allow_ingress_to_coredns" {
  metadata {
    name      = "allow-ingress-to-coredns"
    namespace = kubernetes_namespace_v1.namespace.metadata.0.name
  }

  spec {
    pod_selector {
      match_labels = {
        k8s-app = "coredns"
      }
    }

    policy_types = ["Ingress"]

    ingress {
      from {
        namespace_selector {}
      }
      ports {
        protocol = "UDP"
        port     = 53
      }
      ports {
        protocol = "TCP"
        port     = 53
      }
    }
  }
}

resource "kubernetes_network_policy_v1" "allow_ingress_from_alloy" {
  metadata {
    name      = "allow-grafana-alloy"
    namespace = kubernetes_namespace_v1.namespace.metadata.0.name
  }

  spec {
    policy_types = ["Ingress"]
    pod_selector {}

    ingress {
      from {
        namespace_selector {
          match_expressions {
            key      = "kubernetes.io/metadata.name"
            operator = "In"
            values   = ["alloy"]
          }
        }
      }
    }
  }
}
