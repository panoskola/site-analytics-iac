data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.tenancy_ocid
}

resource "oci_objectstorage_bucket" "backups" {
  compartment_id = local.compartment_id
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = "site-analytics-backups"
  access_type    = "NoPublicAccess"
  storage_tier   = "Standard"
}

# Lets the Object Storage service itself apply the lifecycle (expiry) rule below.
resource "oci_identity_policy" "object_storage_service" {
  compartment_id = var.tenancy_ocid
  name           = "iac-objectstorage-lifecycle"
  description    = "Allow Object Storage to run lifecycle rules"
  statements = [
    "Allow service objectstorage-${var.region} to manage object-family in tenancy",
  ]
}

resource "oci_objectstorage_object_lifecycle_policy" "backups_expiry" {
  namespace = data.oci_objectstorage_namespace.ns.namespace
  bucket    = oci_objectstorage_bucket.backups.name

  rules {
    name        = "delete-old-backups"
    action      = "DELETE"
    is_enabled  = true
    target      = "objects"
    time_amount = 30
    time_unit   = "DAYS"
  }

  depends_on = [oci_identity_policy.object_storage_service]
}

# Instance principal: the VM authenticates as itself, no API keys on the server.
resource "oci_identity_dynamic_group" "web" {
  compartment_id = var.tenancy_ocid
  name           = "iac-web-instances"
  description    = "The iac-web backup host"
  matching_rule  = "instance.id = '${oci_core_instance.web.id}'"
}

resource "oci_identity_policy" "web_backups" {
  compartment_id = var.tenancy_ocid
  name           = "iac-web-backups"
  description    = "iac-web may read and write objects in the backups bucket only"
  statements = [
    "Allow dynamic-group ${oci_identity_dynamic_group.web.name} to manage objects in tenancy where target.bucket.name = '${oci_objectstorage_bucket.backups.name}'",
    "Allow dynamic-group ${oci_identity_dynamic_group.web.name} to read buckets in tenancy where target.bucket.name = '${oci_objectstorage_bucket.backups.name}'",
  ]
}
