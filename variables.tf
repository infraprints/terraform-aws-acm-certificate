variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone to contain the validation record(s)."
}

variable "ttl" {
  type        = string
  description = "The TTL of the validation record(s)."
  default     = "60"
}

