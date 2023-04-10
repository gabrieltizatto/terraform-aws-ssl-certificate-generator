#Certificate pem
resource "aws_s3_bucket_object" "cert_pem" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_foldername,"/cert.pem"])
  content                = acme_certificate.certificates[0].certificate_pem
  server_side_encryption = "aws:kms"
}

#Chain pem
resource "aws_s3_bucket_object" "cert_chain" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_foldername,"/cert.chain"])
  content                = acme_certificate.certificates[0].issuer_pem
  server_side_encryption = "aws:kms"
}

#Private key
resource "aws_s3_bucket_object" "cert_key" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_foldername,"/cert.key"])
  content                = acme_certificate.certificates[0].private_key_pem
  server_side_encryption = "aws:kms"
}

#PFX
resource "aws_s3_bucket_object" "cert_pfx" {
  bucket                 = var.s3_cert_bucket_name
  key                    = join("", ["/", var.s3_cert_foldername,"/cert.pfx"])
  content                = acme_certificate.certificates[0].certificate_p12
  server_side_encryption = "aws:kms"
}
