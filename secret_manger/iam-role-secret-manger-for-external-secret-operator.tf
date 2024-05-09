resource "aws_iam_role" "secret_extrnal_role" {
  name = "secret_extrnal_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/${var.OIDC_URL}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${var.OIDC_URL}:sub": "system:serviceaccount:external-secrets:external-secrets-service-account"
                }
            }
        }
    ]
  })

  tags = {
    tag-key = "secret_extrnal_role"
  }
}

resource "aws_iam_policy" "secret_extrnal_role_policy" {
  name        = "secret_extrnal_role_olicy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecretVersionIds",
            ],
            "Resource": "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:*",
            "Effect": "Allow"
        }
    ]

  })
}


resource "aws_iam_role_policy_attachment" "secret_extrnal_role_policy_attachment" {
  policy_arn = aws_iam_policy.secret_extrnal_role_policy.arn
  role       = aws_iam_role.secret_extrnal_role.name
}