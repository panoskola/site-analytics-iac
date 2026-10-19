output "availability_domains" {
  description = "Availability domains of the region"
  value       = data.oci_identity_availability_domains.ads.availability_domains[*].name
}

output "instance_public_ip" {
  description = "Public IP of the VM"
  value       = oci_core_instance.web.public_ip
}

output "ubuntu_image" {
  description = "Image the VM is built from"
  value       = data.oci_core_images.ubuntu.images[0].display_name
}
