resource "aws_acm_certificate" "default" {
  domain_name               = "${var.domain_name}"
  subject_alternative_names = ["${var.subject_alternative_names}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "validation" {
  count   = "${length(var.subject_alternative_names) + 1}"
  zone_id = "${var.zone_id}"
  ttl     = "${var.ttl}"

  name    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_value")}"]
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.default.arn}"

  validation_record_fqdns = [
    "${aws_route53_record.validation.*.fqdn}",
  ]
}
