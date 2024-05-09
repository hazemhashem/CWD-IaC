  output "eks_name" {
  value = aws_eks_cluster.eks.name
}

  output "OIDC_URL" {
  value = aws_iam_openid_connect_provider.oidc_eks.url
}