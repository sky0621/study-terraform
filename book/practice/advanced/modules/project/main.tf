// GCPプロジェクト自体を作成
resource "google_project" "service" {
  name = var.gcp_project

  // GCPプロジェクトID
  project_id = var.gcp_project
  // 組織ID
  org_id = var.gcp_org
  // 請求先アカウントID
  billing_account = var.billing_account

  // ?
  skip_delete = false
}

// GCPプロジェクトでAPIを有効化
resource "google_project_service" "gcp_api_service" {
  // 対象プロジェクトは当モジュールで作成するGCPプロジェクト
  project = google_project.service.project_id

  // デフォルトで有効にするAPIと追加で有効にするAPIに分かれているが、ここで一緒くたに扱う
  // ※ count はAPI追加変更のたびに大量のリソース変更が発生するので使わない！
  for_each = toset(concat(var.gcp_default_enabled_services, var.gcp_additional_enabled_services))
  service = each.key

  // ?
  disable_on_destroy = false
}

// ロール「roles/viewer」を割り当てる
resource "google_project_iam_member" "service_viewers" {
  // 対象プロジェクトは当モジュールで作成するGCPプロジェクト
  project = google_project.service.project_id

  // 誰にロールを割り当てるか
  for_each = toset(var.service_viewers)
  member = "user:${each.key}"

  // 何のロールを割り当てるか
  role = "roles/viewer"
}

// ロール「roles/editor」を割り当てる
resource "google_project_iam_member" "service_admins" {
  // 対象プロジェクトは当モジュールで作成するGCPプロジェクト
  project = google_project.service.project_id

  // 誰にロールを割り当てるか
  for_each = toset(var.service_admins)
  member = "user:${each.key}"

  // 何のロールを割り当てるか
  role = "roles/editor"
}
