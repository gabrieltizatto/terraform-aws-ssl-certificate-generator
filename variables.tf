variable "server_url" {
  description = "The full URL of the ACMEv2-compatible server to use. Defaults to Let's Encrypt's staging."
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory" # To switch to Let's Encrypt production, set to `https://acme-v02.api.letsencrypt.org/directory`.
}

variable "email_address" {
  description = "The contact email address for the account."
  type        = string
}

variable "certificates" {
  description = "The certificates to be issued."
  type = list(object({
    common_name               = string       # The certificate's common name, the primary domain that the certificate will be recognized for. Required when not specifying a CSR.
    subject_alternative_names = list(string) # The certificate's subject alternative names, domains that this certificate will also be recognized for. Only valid when not specifying a CSR.
    key_type                  = string       # The key type for the certificate's private key. Can be one of: `P256` and `P384` (for ECDSA keys of respective length) or `2048`, `4096`, and `8192` (for RSA keys of respective length). Required when not specifying a CSR. The default is `2048` (RSA key of 2048 bits).
    certificate_request_pem   = string       # A pre-created certificate request, such as one from `tls_cert_request`, or one from an external source, in PEM format. Either this, or the in-resource request options (`common_name`, `key_type`, and optionally `subject_alternative_names`) need to be specified.
    must_staple               = bool         # Enables the OCSP Stapling Required TLS Security Policy extension. Certificates with this extension must include a valid OCSP Staple in the TLS handshake for the connection to succeed. Defaults to `false`. Note that this option has no effect when using an external CSR - it must be enabled in the CSR itself.
    min_days_remaining        = number       # The minimum amount of days remaining on the expiration of a certificate before a renewal is attempted. The default is `30`. A value of less than `0` means that the certificate will never be renewed.
    certificate_p12_password  = string       # Password to be used when generating the PFX file stored in `certificate_p12`. Defaults to an empty string.
  }))
}

variable "external_account_binding" {
  description = "An external account binding for the registration, usually used to link the registration with an account in a commercial CA."
  type = object({
    key_id      = string # The key ID for the external account binding.
    hmac_base64 = string # The base64-encoded message authentication code for the external account binding.
  })
  default = null
}

variable "account_private_key_rsa_bits" {
  description = "The size of the generated RSA key in bits. Defaults to 2048."
  type        = number
  default     = null
}

variable "recursive_nameservers" {
  description = "The recursive nameservers that will be used to check for propagation of the challenge record. Defaults to your system-configured DNS resolvers."
  type        = list(string)
  default     = null
}

variable "disable_complete_propagation" {
  description = "Disable the requiement for full propagation of the TXT challenge record before proceeding with validation. Defaults to false. Only recommended for testing."
  type        = bool
  default     = null
}

variable "pre_check_delay" {
  description = "Insert a delay after every DNS challenge record to allow for extra time for DNS propagation before the certificate is requested. Use this option if you observe issues with requesting certificates even when DNS challenge records get added successfully. Units are in seconds. Defaults to 0 (no delay)."
  type        = number
  default     = null
}

variable "aws_hosted_zone_id" {
  description = "AWS Hosted Zone ID for the domain"
  type        = string
  default     = null
}

variable "s3_cert_folder_name" {
  type = string
}

variable "s3_cert_bucket_name" {
  type = string
}

variable "letsencrypt_iam_user" {
  description = "Name of the IAM user"
  type        = string
  default     = "letsencrypt"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = null
}
variable "dns_challenge_provider" {
  description = "DNS Challange Provider"
  type        = string
  default     = "route53"
}

variable "create_iam_user" {
  default = false
}

variable "iam_access_key" {
  type    = string
  default = null
}

variable "iam_secret_access_key" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}