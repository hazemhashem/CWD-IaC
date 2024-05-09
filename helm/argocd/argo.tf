resource "kubernetes_namespace" "argo_ns" {
  metadata {
      name = "argocd"
    }
    depends_on = [var.aws_eks_cluster]
}

resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"

  depends_on = [kubernetes_namespace.argo_ns]

  values = [
    <<-EOT
    server:
      service:
        type: LoadBalancer
    EOT
  ]
}
