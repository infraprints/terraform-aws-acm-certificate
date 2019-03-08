provider "aws" {
  region = "us-east-1"
}

data "aws_route53_zone" "zone" {
  name = "${var.domain}"
}

module "example" {
  source = "../../"

  domain_name               = "${var.domain}"
  zone_id                   = "${data.aws_route53_zone.zone.id}"
  subject_alternative_names = "${var.names}"
}

variable "names" {
  type        = "list"
  description = "A list of subdomains"
}

variable "domain" {
  type        = "string"
  description = "The domain"
}
