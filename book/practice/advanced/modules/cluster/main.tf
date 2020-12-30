// 「project」モジュールを使う
module "project" {
  source      = "../project"
  gcp_project = local.service_name_with_env
}

locals {
  service_name_with_env = "${var.service_name}-${var.env}"
}

// GKEでk8sのコントロールプレーンを管理
resource "google_container_cluster" "primary" {
  name = "primary"

  // 「project」モジュール経由で対象プロジェクトを指定
  project  = module.project.project_id
  location = var.gcp_region

  // VPCネイティブクラスタ設定
  // https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = ""
    services_ipv4_cidr_block = ""
  }

  // Workload Identity利用設定
  // https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity
  workload_identity_config {
    identity_namespace = "${module.project.project_id}.svc.id.goog"
  }

  initial_node_count = 1

  // ?
  remove_default_node_pool = true
}

// ノードプールでk8sのデータプレーンを管理
resource "google_container_node_pool" "primary" {
  name = "primary"

  // 「project」モジュール経由で対象プロジェクトを指定
  project  = module.project.project_id
  location = var.gcp_region

  // GKEクラスタと紐づけ
  cluster = google_container_cluster.primary.name

  node_count = 1
  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    // Workload Identity利用設定
    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER"
    }

    metadata = {
      // ?
      disable-legacy-endpoints = "true"
    }

    // ?
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  lifecycle {
    // 負荷に応じて増減するため
    ignore_changes = [node_count]
  }
}
