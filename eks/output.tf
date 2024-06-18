  output "eks_name" {
  value = aws_eks_cluster.eks.name
}

  output "OIDC_URL" {
  value = aws_iam_openid_connect_provider.oidc_eks.url
}
  output "OIDC_ARN" {
  value = aws_iam_openid_connect_provider.oidc_eks.arn
}


output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.eks.certificate_authority.0.data
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks.name
}