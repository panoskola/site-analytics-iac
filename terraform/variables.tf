variable "tenancy_ocid" {
  description = "OCID of the Oracle Cloud tenancy"
  type        = string
}

variable "user_ocid" {
  description = "OCID of the user that owns the API key"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint of the API public key"
  type        = string
}

variable "private_key_path" {
  description = "Path to the API private key"
  type        = string
  default     = "~/.oci/oci_api_key.pem"
}

variable "region" {
  description = "Oracle Cloud region"
  type        = string
  default     = "eu-frankfurt-1"
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to reach SSH (port 22)"
  type        = string
  default     = "0.0.0.0/0"
}
