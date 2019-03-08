provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "zone" {
  name = "${var.domain}"
}

module "example" {
  source = "../../"

  domain_name = "${var.domain}"
  zone_id     = "${aws_route53_zone.zone.id}"
}

variable "domain" {
  type        = "string"
  description = "The domain"
}
