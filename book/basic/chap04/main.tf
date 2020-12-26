resource "google_compute_instance" "default" {
  machine_type = "f1-micro"
  name = "test3"
  zone = "asia-northeast1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }
}