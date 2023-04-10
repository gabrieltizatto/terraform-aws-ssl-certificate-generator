resource "aws_s3_bucket" "this" {
  bucket = var.s3_cert_bucket_name

  tags = var.tags
}

#Certificate pem
resource "aws_s3_bucket_object" "cert_pem" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_folder_name,"/cert.pem"])
  content                = acme_certificate.certificates[0].certificate_pem
  server_side_encryption = "aws:kms"

  depends_on = [
    aws_s3_bucket.this
  ]

  tags = var.tags
}

#Chain pem
resource "aws_s3_bucket_object" "cert_chain" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_folder_name,"/cert.chain"])
  content                = acme_certificate.certificates[0].issuer_pem
  server_side_encryption = "aws:kms"

  depends_on = [
    aws_s3_bucket.this
  ]

  tags = var.tags
}

#Private key
resource "aws_s3_bucket_object" "cert_key" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_folder_name,"/cert.key"])
  content                = acme_certificate.certificates[0].private_key_pem
  server_side_encryption = "aws:kms"

  depends_on = [
    aws_s3_bucket.this
  ]

  tags = var.tags
}

#PFX
resource "aws_s3_bucket_object" "cert_pfx" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_folder_name,"/cert.pfx"])
  content                = acme_certificate.certificates[0].certificate_p12
  server_side_encryption = "aws:kms"

  depends_on = [
    aws_s3_bucket.this
  ]

  tags = var.tags
}
