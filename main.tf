terraform {
  # experiments = [module_variable_optional_attrs]

  required_providers {
    acme = {
      source = "vancluever/acme"
    }
  }
}

provider "acme" {
  server_url = var.server_url
}

provider "tls" {}

resource "tls_private_key" "registration" {
  algorithm = "RSA"
  rsa_bits  = var.account_private_key_rsa_bits
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.registration.private_key_pem
  email_address   = var.email_address

  dynamic "external_account_binding" {
    for_each = var.external_account_binding != null ? [null] : []
    content {
      key_id      = var.external_account_binding.key_id
      hmac_base64 = var.external_account_binding.hmac_base64
    }
  }
}

resource "acme_certificate" "certificates" {
  for_each = { for certificate in var.certificates : index(var.certificates, certificate) => certificate }

  common_name               = each.value.common_name
  subject_alternative_names = each.value.subject_alternative_names
  key_type                  = each.value.key_type
  must_staple               = each.value.must_staple
  min_days_remaining        = each.value.min_days_remaining
  certificate_p12_password  = each.value.certificate_p12_password

  account_key_pem              = acme_registration.registration.account_key_pem
  recursive_nameservers        = var.recursive_nameservers
  disable_complete_propagation = var.disable_complete_propagation
  pre_check_delay              = var.pre_check_delay

  dns_challenge {
      provider = var.dns_challenge_provider
      config   = {
        AWS_ACCESS_KEY_ID     = var.create_iam_user ? aws_iam_access_key.letsencrypt_access_key.*.id : var.iam_access_key 
        AWS_SECRET_ACCESS_KEY = var.create_iam_user? aws_iam_access_key.letsencrypt_access_key.*.secret : var.iam_secret_access_key
        AWS_DEFAULT_REGION    = var.region
        AWS_HOSTED_ZONE_ID    = var.aws_hosted_zone_id
      }
    }
}

    var.give_neo_cloudwatch_full_access
    ? aws_iam_user_policy_attachment.full_access[0].policy_arn
    : aws_iam_user_policy_attachment.read_only[0].policy_arn

resource "aws_acm_certificate" "cert" {
  private_key        =  acme_certificate.certificates[0].private_key_pem   ###tls_private_key.example.private_key_pem
  certificate_body   =  acme_certificate.certificates[0].certificate_pem ####tls_self_signed_cert.example.cert_pem
  certificate_chain  =  acme_certificate.certificates[0].issuer_pem
  depends_on         =  [acme_certificate.certificates,tls_private_key.registration,acme_registration.registration]
}
