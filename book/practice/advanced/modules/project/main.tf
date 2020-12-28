resource "google_project" "service" {
  name = var.gcp_project
  project_id = var.gcp_project
  org_id = var.gcp_org
  billing_account = var.billing_account

  skip_delete = false
}

resource "google_project_service" "gcp_api_service" {
  for_each = toset(concat(var.gcp_default_enabled_services, var.gcp_additional_enabled_services))

  project = google_project.service.project_id
  service = each.key

  disable_on_destroy = false
}

resource "google_project_iam_member" "service_viewers" {
  for_each = toset(var.service_viewers)

  project = google_project.service.project_id
  member = "user:${each.key}"
  role = "roles/viewer"
}

resource "google_project_iam_member" "service_admins" {
  for_each = toset(var.service_admins)

  project = google_project.service.project_id
  member = "user:${each.key}"
  role = "roles/editor"
}
