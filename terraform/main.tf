terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ECR Repository to store Docker image
resource "aws_ecr_repository" "sentiment_app" {
  name = "mlops-sentiment-app"
}

# IAM Role for Lambda/ECS to access Comprehend
resource "aws_iam_role" "app_role" {
  name = "mlops-sentiment-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Comprehend policy to role
resource "aws_iam_role_policy_attachment" "comprehend_policy" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/ComprehendReadOnly"
}

# Output the ECR repository URL
output "ecr_repository_url" {
  value = aws_ecr_repository.sentiment_app.repository_url
}