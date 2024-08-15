# resource "kubernetes_manifest" "default_deny_all" {
#   manifest = {
#     "apiVersion" = "security.istio.io/v1"
#     "kind"       = "AuthorizationPolicy"
#     "metadata" = {
#       "name"      = "default-deny-all"
#       "namespace" = kubernetes_namespace_v1.namespace.metadata[0].name
#     }
#     "spec" = {}
#   }
# }

resource "kubernetes_manifest" "allow_from_same_namespace" {
  manifest = {
    "apiVersion" = "security.istio.io/v1"
    "kind"       = "AuthorizationPolicy"
    "metadata" = {
      "name"      = "allow-from-same-namespace"
      "namespace" = kubernetes_namespace_v1.namespace.metadata[0].name
    }
    "spec" = {
      "rules" = [
        {
          "from" = [
            {
              "source" = {
                "namespaces" = [kubernetes_namespace_v1.namespace.metadata[0].name]
              }
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "allow_ingress_from_ingress" {
  manifest = {
    "apiVersion" = "security.istio.io/v1"
    "kind"       = "AuthorizationPolicy"
    "metadata" = {
      "name"      = "allow-ingress"
      "namespace" = kubernetes_namespace_v1.namespace.metadata[0].name
    }
    "spec" = {
      "rules" = [
        {
          "from" = [
            {
              "source" = {
                "namespaces" = ["ingress"]
              }
            }
          ]
        }
      ]
    }
  }
}


resource "kubernetes_manifest" "allow_ingress_from_alloy" {
  manifest = {
    "apiVersion" = "security.istio.io/v1"
    "kind"       = "AuthorizationPolicy"
    "metadata" = {
      "name"      = "allow-grafana-alloy"
      "namespace" = kubernetes_namespace_v1.namespace.metadata[0].name
    }
    "spec" = {
      "rules" = [
        {
          "from" = [
            {
              "source" = {
                "namespaces" = ["alloy"]
              }
            }
          ]
        }
      ]
    }
  }
}
