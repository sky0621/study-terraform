variable "project_id" {
  description = "Name of a GCP project"
  type        = string
}

// 組織ID
variable "gcp_org" {
  description = "GCP organization id"
  type        = string
  default     = null
}

// 請求先アカウント
variable "billing_account" {
  description = "Billing account for the GCP project"
  type        = string
  default     = null
}
