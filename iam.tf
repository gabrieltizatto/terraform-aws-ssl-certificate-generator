resource "aws_iam_user" "letsencrypt_user" {
  count = var.create_iam_user ? 1 : 0
  name = var.letsencrypt_iam_user

  tags = var.tags
}

resource "aws_iam_access_key" "letsencrypt_access_key" {
  count = var.create_iam_user ? 1 : 0
  user = aws_iam_user.letsencrypt_user[0].name
}

resource "aws_iam_policy_attachment" "R53" {
  count = var.create_iam_user ? 1 : 0
  name       = "Route53-admin"
  users      = [aws_iam_user.letsencrypt_user[0].name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_policy_attachment" "ACM" {
  count = var.create_iam_user ? 1 : 0
  name       = "Route53-admin"
  users      = [aws_iam_user.letsencrypt_user[0].name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess"
}

resource "aws_iam_policy_attachment" "S3" {
  count = var.create_iam_user ? 1 : 0
  name       = "Route53-admin"
  users      = [aws_iam_user.letsencrypt_user[0].name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

