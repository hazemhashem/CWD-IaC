module "argocd" {
    source = "./argocd"
    aws_eks_cluster = var.eks_cluster
}
