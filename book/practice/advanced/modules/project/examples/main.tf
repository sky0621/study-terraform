module "project" {
  source = "../../project"
  gcp_project = var.project_id
  gcp_org = var.gcp_org
  billing_account = var.billing_account
}
