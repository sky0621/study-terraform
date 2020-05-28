provider "google" {
  version = "3.5.0"

  credentials = "~/.config/gcloud/my-gcp-prj-01-terraform-credential.json"

  project = ""
  region = "asia-northeast1"
  zone = "asia-northeast1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
