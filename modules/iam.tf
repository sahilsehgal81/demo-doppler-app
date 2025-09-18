# IAM Role for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name = "${local.name}-${local.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.env}-${var.project}-ec2-role"
  }
}

# Attach AmazonEC2ContainerRegistryFullAccess policy to the role
resource "aws_iam_role_policy_attachment" "ec2_ecr_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# Create instance profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.env}-${var.project}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
