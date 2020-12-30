// 「project」モジュールを使う
module "project" {
  source      = "../project"
  gcp_project = local.service_name_with_env
}

locals {
  service_name_with_env = "${var.service_name}-${var.env}"
}

// サービスアカウント作成
resource "google_service_account" "pod_default" {
  // 「project」モジュール経由で対象プロジェクトを指定
  project = module.project.project_id

  account_id   = "pod-default"
  display_name = "pod-default"
}

// サービスアカウントに権限付与
resource "google_service_account_iam_binding" "pod_default_is_workload_identity_user" {
  members = [
    "serviceAccount:${var.gke_project}.svc.id.goog[${kubernetes_namespace.microservice.metadata[0].name}/${kubernetes_service_account.pod_default.metadata[0].name}]"
  ]
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.pod_default.name
}

// k8sのネームスペース作成
resource "kubernetes_namespace" "microservice" {
  metadata {
    name = local.service_name_with_env
    labels = {
      namespace = local.service_name_with_env
    }
  }
}

// k8sのネームスペース内にサービスアカウントを作成
resource "kubernetes_service_account" "pod_default" {
  metadata {
    name      = "pod-default"
    namespace = kubernetes_namespace.microservice.metadata[0].name

    annotations = {
      // Workload Identity有効化によりアノテーションの記述でGCPのサービスアカウントと紐づけ可能
      "iam.gke.io/gcp-service-account" = "${google_service_account.pod_default.account_id}@${module.project.project_id}.iam.gserviceaccount.com"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding
resource "kubernetes_role_binding" "service_admins_is_view" {
  for_each = toset(var.service_viewers)

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    name      = "view"
    kind      = "ClusterRole"
  }

  metadata {
    name      = "${replace(each.key, "/@.*/", "")}-is-view"
    namespace = kubernetes_namespace.microservice.metadata[0].name
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = each.key
    namespace = ""
  }
}

resource "kubernetes_role_binding" "service_admins_is_admin" {
  for_each = toset(var.service_admins)

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    name      = "edit"
    kind      = "ClusterRole"
  }

  metadata {
    name      = "${replace(each.key, "/@.*/", "")}-is-edit"
    namespace = kubernetes_namespace.microservice.metadata[0].name
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = each.key
    namespace = ""
  }
}

// コンテナイメージの取得元
resource "google_artifact_registry_repository" "container" {
  // 「project」モジュール経由で対象プロジェクトを指定
  project  = module.project.project_id
  location = var.gcp_region

  provider = google-beta

  format        = "DOCKER"
  repository_id = "container"
}

resource "google_artifact_registry_repository_iam_member" "pod_default_is_artifact_registry_reader" {
  // 「project」モジュール経由で対象プロジェクトを指定
  project = module.project.project_id

  provider = google-beta

  location   = google_artifact_registry_repository.container.location
  repository = google_artifact_registry_repository.container.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.pod_default.email}"
}

// Bigqueryのデータセットを作成
resource "google_bigquery_dataset" "container_log" {
  // 「project」モジュール経由で対象プロジェクトを指定
  project  = module.project.project_id
  location = var.gcp_region

  dataset_id = "container_log"
}

resource "google_logging_project_sink" "from_container_to_bq" {
  name = "from-container-to-bq"

  // 「project」モジュール経由で対象プロジェクトを指定
  project = module.project.project_id

  destination = "bigquery.googleapis.com/projects/${module.project.project_id}/datasets/${google_bigquery_dataset.container_log.dataset_id}"
}
