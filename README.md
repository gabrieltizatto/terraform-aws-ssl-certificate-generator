# LetsEncrypt Module

## Example of usage:

```


module "acme" {
  source = "/Users/gabrieltizatto/Projects/personal/terraform/terraform-aws-ssl-certificate-generator"

  email_address          = "example@email.com"
  aws_hosted_zone_id     = "<hosted_zone_id>"
  region                 = "us-east-1"
  dns_challenge_provider = "route53"

  create_iam_user = true
  
  s3_cert_bucket_name = "<s3_bucket_name>"
  s3_cert_folder_name  = "<s3_bucket_foldername>"

  certificates = [{
      common_name = "domain.com",
      subject_alternative_names = ["sub.domain.com"],
      key_type = null,
      certificate_request_pem = null,
      must_staple = false,
      certificate_p12_password = null,
      min_days_remaining = 40
    },
  ]
}



```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key\_arn | The ARN of the secret from AWS Secrets Manager that is storing the ACCESS KEY. | `any` | `null` | no |
| aliases | Extra CNAMEs (alternate domain names), if any, for this distribution. | `list` | `null` | no |
| allowed\_methods | Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. | `list(string)` | n/a | yes |
| cached\_methods | Controls whether CloudFront caches the response to requests using the specified HTTP methods. | `list(string)` | n/a | yes |
| cloudfront\_default\_certificate | true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. | `string` | `"false"` | no |
| comment | Any comments you want to include about the distribution. | `any` | `null` | no |
| compress | Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false). | `string` | `"false"` | no |
| create\_oai | Whether you want to create Origin Access Identity | `string` | `"false"` | no |
| custom\_error\_response | List of maps of one or more custom error response elements (multiples allowed). | `list(map(string))` | `[]` | no |
| custom\_origins | A list of maps to describe Custom Origins | `list(map(string))` | `[]` | no |
| default\_root\_object | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `any` | `null` | no |
| default\_ttl | The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. | `string` | `"86400"` | no |
| enabled | Whether the distribution is enabled to accept end user requests for content. | `any` | n/a | yes |
| field\_level\_encryption\_id | Field level encryption configuration ID | `any` | `null` | no |
| forward | Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. | `any` | n/a | yes |
| headers | Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify \* to include all headers. | `any` | `null` | no |
| http\_version | The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2. | `string` | `"http2"` | no |
| iam\_certificate\_id | The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. | `any` | `null` | no |
| is\_ipv6\_enabled | Whether the IPv6 is enabled for the distribution. | `any` | `null` | no |
| logging\_config | A list of maps to describe S3 logging bucket | `list(map(string))` | `[]` | no |
| max\_ttl | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. | `string` | `"31536000"` | no |
| min\_ttl | The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. | `string` | `"0"` | no |
| minimum\_protocol\_version | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | `string` | `"TLSv1"` | no |
| oai\_comment | Origin Access Identity Comment | `any` | `null` | no |
| ordered\_cache\_behavior | An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0. | `list(any)` | `[]` | no |
| price\_class | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `"PriceClass_100"` | no |
| query\_string | Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior. | `any` | n/a | yes |
| query\_string\_cache\_keys | When specified, along with a value of true for query\_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query\_string, all query string keys are cached. | `any` | `null` | no |
| restriction\_locations | The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). | `any` | `null` | no |
| restriction\_type | The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | `"none"` | no |
| retain\_on\_delete | Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. | `string` | `"false"` | no |
| s3\_origins | A list of maps to describe S3 Origins | `list(map(string))` | `[]` | no |
| s3\_origins\_oai | A list of maps to describe S3 Origins with Origin Access Identity | `list(map(string))` | `[]` | no |
| smooth\_streaming | Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior. | `any` | `null` | no |
| ssl\_support\_method | Specifies how you want CloudFront to serve HTTPS requests. | `any` | `null` | no |
| tags | A map of tags to assign to the resource. | `map` | `null` | no |
| target\_origin\_id | The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior. | `any` | n/a | yes |
| trusted\_signers | The AWS accounts, if any, that you want to allow to create signed URLs for private content. | `any` | `null` | no |
| viewer\_protocol\_policy | Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https. | `any` | n/a | yes |
| wait\_for\_deployment | If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. | `string` | `"true"` | no |
| web\_acl\_id | If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. | `any` | `null` | no |
| whitelisted\_names | If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin. | `any` | `null` | no |
| create\_iam\_user | If you want the module to create the IAM user that will be used for validating the certificate for you. | `bool` | `false` | no |
| s3\_cert\_folder\_name | S3 folder name to store the certs. | `string` | n/a | yes |
| s3\_cert\_bucket\_name | S3 bucket name that will be created to store the certs. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN (Amazon Resource Name) for the distribution. |
| domain\_name | The domain name corresponding to the distribution. |
| id | The identifier for the distribution. |
