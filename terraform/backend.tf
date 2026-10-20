# State lives in OCI Object Storage via its S3-compatible API.
# Bucket, endpoint and credentials are supplied at init time:
#   terraform init -backend-config=backend.hcl
# See backend.hcl.example. CI runs `init -backend=false`, so it is unaffected.
terraform {
  backend "s3" {
    key                         = "site-analytics-iac/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}
