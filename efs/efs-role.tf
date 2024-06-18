data "aws_iam_policy_document" "efs_csi_driver" {
  statement {
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "ec2:DescribeAvailabilityZones"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "elasticfilesystem:CreateAccessPoint"
    ]
    resources = ["*"]
    effect    = "Allow"
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions = [
      "elasticfilesystem:DeleteAccessPoint"
    ]
    resources = ["*"]
    effect    = "Allow"
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }
}
# create policy
resource "aws_iam_policy" "eks_efs_driver_policy" {
  name        = "efs-csi-driver-policy"
  description = "allow EKS access to EFS"
  policy      = data.aws_iam_policy_document.efs_csi_driver.json
}


# create role

resource "aws_iam_role" "eks_efs_driver_role" {
  name               = "efs-csi-driver-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.OIDC_ARN
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "oidc.eks.${var.region}.amazonaws.com/id/${basename(var.OIDC_URL)}:sub" = "system:serviceaccount:kube-system:aws-efs-csi-driver-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "eks_efs_driver_attach" {
  name       = "eks_efs_driver_attach"
  roles      = [aws_iam_role.eks_efs_driver_role.name]
  policy_arn = aws_iam_policy.eks_efs_driver_policy.arn
}



resource "helm_release" "efs_csi_driver" {

  name = "efs-csi-driver"

  namespace       = "kube-system"
  cleanup_on_fail = true
  force_update    = true

  chart = "https://github.com/kubernetes-sigs/aws-efs-csi-driver/releases/download/helm-chart-aws-efs-csi-driver-2.2.7/aws-efs-csi-driver-2.2.7.tgz"

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/aws-efs-csi-driver"
  }

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "aws-efs-csi-driver-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.eks_efs_driver_role.arn #kubernetes_service_account.efs_csi_driver.metadata.0.name
  }

  set {
    name  = "node.serviceAccount.create"
    value = "false"
  }

  set {
    name  = "node.serviceAccount.name"
    value = "aws-efs-csi-driver-sa"
  }

  set {
    name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.eks_efs_driver_role.arn
  }

  depends_on = [
   aws_efs_mount_target.efs_target_1,
   aws_efs_mount_target.efs_target_2
  ]

}

