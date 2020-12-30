// GCPプロジェクトID
variable "gcp_project" {
  description = "GCP project name"
  type = string
  default = null
}

// 組織ID
variable "gcp_org" {
  description = "GCP organization id"
  type = string
  default = null
}

// 請求先アカウント
variable "billing_account" {
  description = "Billing account for the GCP project"
  type = string
  default = null
}

// GCPプロジェクトでデフォルトで有効化するAPI一覧
variable "gcp_default_enabled_services" {
  description = "GCP API services to be enabled by default"
  type = list(string)

  default = [
    "audit.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerystorage.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "stackdriver.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}

// GCPプロジェクトで追加で有効化するAPI一覧
variable "gcp_additional_enabled_services" {
  description = "Additional GCP API services to be enalbed per project"
  type = list(string)

  default = []
}

// ロール「roles/viewer」を割り当てるメンバー一覧
variable "service_viewers" {
  description = "Viewers of the service"
  type = list(string)
  default = []
}

// ロール「roles/editor」を割り当てるメンバー一覧
variable "service_admins" {
  description = "Admins of the service"
  type = list(string)
  default = []
}
