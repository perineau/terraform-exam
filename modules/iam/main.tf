resource "aws_iam_user" "user" {
    name = each.value

    for_each = toset(var.users)
}

resource "aws_iam_group" "group" {
    name = var.group
}

resource "aws_iam_user_group_membership" "attache_group" {
    user = aws_iam_user.user[each.key].name 

    groups = [
        aws_iam_group.group.name,
    ]
    for_each = toset(var.users)

}

resource "aws_iam_policy_attachment" "attach_policy" {
  name       = "attachment"
  users      = [aws_iam_user.user[each.key].name ]
  policy_arn = aws_iam_policy.admin.arn
    for_each = toset(var.users)
}

resource "aws_iam_policy" "admin" {
  name = "administrator_access"
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
