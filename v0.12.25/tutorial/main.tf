provider "google" {
  version = "3.5.0"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-c"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
