resource "aws_eks_cluster" "eks" {
  name     = "${var.eks_name}"
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [var.public_subnet_id_1,var.public_subnet_id_2,
                  var.private_subnet_id_1,var.private_subnet_id_2]
  }


  tags = {
    Name = "eks"
  }

      provisioner "local-exec" {
    command = <<EOT
        aws eks update-kubeconfig --region "${var.region}" --name "${var.eks_name}"
        export KUBECONFIG=~/.kube/config
    EOT
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]
}