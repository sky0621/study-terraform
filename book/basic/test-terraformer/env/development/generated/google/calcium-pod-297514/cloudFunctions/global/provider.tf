provider "google" {
  project = "calcium-pod-297514"
}

terraform {
  required_providers {
    google = {
      version = "~> 3.51.0"
    }
  }
}
