# AWS S3 Terraform State Output

Terraform module for provisioning a DNS validated certificate, along with the required validation records. The module will wait for validation to complete.

These types of resources are supported:

- [ACM Certificate](https://www.terraform.io/docs/providers/aws/r/acm_certificate.html)
- [ACM Certificate Validation](https://www.terraform.io/docs/providers/aws/r/acm_certificate_validation.html)

## Usage

```hcl
module "certificate" {
  source = "git::https://gitlab.com/infraprints/modules/aws/acm-certificate"

  zone_id     = "${data.aws_route53_zone.zone.id}"
  domain_name = "infraprints.io"

  subject_alternative_names = [
    "api.infraprints.io",
    "dev.infraprints.io",
  ]
}

data "aws_route53_zone" "zone" {
  name = "infraprints.io"
}
```

## Examples

- [Basic Example](examples/basic)
- [Multiple Records Example](examples/multi)

## Notes

- The module deploys the required validation records and wait for validation to complete, which can take upwards to 30 minutes.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain\_name | A domain name for which the certificate should be issued | string | n/a | yes |
| subject\_alternative\_names | A list of domains that should be SANs in the issued certificate | list | `<list>` | no |
| ttl | The TTL of the validation record(s). | string | `"60"` | no |
| zone\_id | The ID of the hosted zone to contain the validation record(s). | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |