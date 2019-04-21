provider "aws" {
  region = "us-east-1"
}

data "aws_route53_zone" "zone" {
  name = "${var.domain}"
}

module "example" {
  source = "../../"

  domain_name = "${var.domain}"
  zone_id     = "${data.aws_route53_zone.zone.id}"
}

variable "domain" {
  type        = "string"
  description = "The domain"
}
