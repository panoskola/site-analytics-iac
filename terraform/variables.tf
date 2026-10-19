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

variable "ssh_public_key_path" {
  description = "Path to the SSH public key installed on the VM"
  type        = string
  default     = "~/.ssh/oci_iac.pub"
}

variable "instance_ocpus" {
  description = "OCPUs for the VM (Always Free total: 2 across all A1 VMs)"
  type        = number
  default     = 1
}

variable "instance_memory_gb" {
  description = "Memory in GB for the VM (Always Free total: 12 across all A1 VMs)"
  type        = number
  default     = 6
}
