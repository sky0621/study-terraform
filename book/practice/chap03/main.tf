resource "google_compute_instance_template" "default" {
  name_prefix = "default-"
  machine_type = "f1-micro"

  disk {
    source_image = "debian-cloud/debian-9"
  }

  network_interface {
    network = "default"
  }
}

resource "google_compute_region_instance_group_manager" "default" {
  base_instance_name = "mig"
  target_size = 6
  name = "default"
  region = var.compute_instance_region
  version {
    instance_template = google_compute_instance_template.default.self_link
  }
}

resource "google_compute_region_autoscaler" "default" {
  name = "default"
  region = var.compute_instance_region
  target = google_compute_region_instance_group_manager.default.self_link
  autoscaling_policy {
    max_replicas = 10
    min_replicas = 6
  }
}

resource "google_compute_health_check" "mig_health_check" {
  name = "default"

  http2_health_check {
    port = 80
  }
}

resource "google_compute_firewall" "mig_health_check" {
  name = "health-check"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [80]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags = ["allow-service"]
}
