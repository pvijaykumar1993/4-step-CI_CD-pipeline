provider "aws" {
  region = "us-west-2"
}

resource "aws_ecr_repository" "my_app_repo" {
  name = "my-app-repo"
}

resource "aws_iam_role" "ecr_role" {
  name = "my-app-ecr-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecr.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-policy"
  description = "ECR push/pull policy"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = [
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage"
      ]
      Effect   = "Allow"
      Resource = aws_ecr_repository.my_app_repo.arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.ecr_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}
