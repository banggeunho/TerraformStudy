resource "aws_iam_group" "devops_group" {
 name = "devops"
}


resource "aws_iam_group_membership" "devops" {

  name = aws_iam_group.devops_group.name
 
  users = [
    aws_iam_user.gildong_hong.name
  ]

  group = aws_iam_group.devops_group.name
}


resource "aws_iam_group_policy" "group_policy" {
  name  = "group_policy"
  group = aws_iam_group.devops_group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

