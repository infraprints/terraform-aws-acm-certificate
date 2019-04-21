output "validation_record_fqdns" {
  value       = "${aws_acm_certificate_validation.default.validation_record_fqdns}"
  description = "List of FQDNs that implement the validation."
}

output "id" {
  value       = "${aws_acm_certificate.default.id}"
  description = "The ARN of the certificate."
}

output "arn" {
  value       = "${aws_acm_certificate_validation.default.certificate_arn}"
  description = "The ARN of the certificate that is being validated."
}

output "fqdn" {
  value       = "${aws_route53_record.validation.*.fqdn}"
  description = "[FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name) built using the zone domain and name."
}

output "domain_name" {
  value       = "${aws_acm_certificate.default.domain_name}"
  description = "The domain name for which the certificate is issued."
}
