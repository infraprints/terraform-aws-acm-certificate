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
