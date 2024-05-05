resource "kubernetes_namespace" "prometheus_ns" {
  metadata {
    name = "monitoring"
  }
  depends_on = [var.aws_eks_cluster]
}


resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "prometheus-community"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.prometheus_ns.metadata.0.name

  depends_on = [kubernetes_namespace.prometheus_ns]

 values = [
    <<-EOT
    prometheus:
      prometheusSpec:
        service:
          type: LoadBalancer
    grafana:
      enabled: true
      service:
        type: LoadBalancer
    EOT
  ]
}
