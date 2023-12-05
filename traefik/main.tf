resource "helm_release" "traefik" {

  namespace        = var.namespace
  create_namespace = true
  name             = "traefik"
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  version          = var.traefik_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  set {
    name  = "deployment.replicas"
    value = var.replica_count
  }
}




resource "kubernetes_manifest" "kube_manifest" {
  for_each = fileset("${path.module}/manifests/", "*.yaml")
  manifest = yamldecode(file("${path.module}/manifests/${each.key}"))
}

