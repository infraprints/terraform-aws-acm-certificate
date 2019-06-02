resource "aws_acm_certificate" "default" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
}

resource "aws_route53_record" "validation" {
  count   = length(var.subject_alternative_names) + 1
  zone_id = var.zone_id
  ttl     = var.ttl

  name = aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_name"]
  type = aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_type"]
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  records = [aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_value"]]
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = aws_acm_certificate.default.arn

  validation_record_fqdns = aws_route53_record.validation.*.fqdn
}

