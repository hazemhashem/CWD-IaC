resource "aws_eks_node_group" "private-ng" {
  cluster_name    = var.eks_name
  node_group_name = var.node_name
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = [var.private_subnet_id_1,var.private_subnet_id_2]
  ami_type = var.ami_type
  capacity_type = var.capacity_type
  disk_size = var.disk_size
  instance_types = [var.instance_types]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEBSCSIDriverPolicy,
    aws_iam_role_policy_attachment.secret_manager_policy_for_eks_nodes,
    aws_iam_role_policy_attachment.AutoscalingSetDesiredCapacityPolicy,
  ]
    tags = {
        name = "worker-node-1"
    }
}