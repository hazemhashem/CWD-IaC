module "argocd" {
    source = "./argocd"
    aws_eks_cluster = var.eks_cluster
}

module "prometheus" {
    source = "./prometheus-stack"
    aws_eks_cluster = var.eks_cluster
  
}