output "availability_domains" {
  description = "Availability domains of the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}
