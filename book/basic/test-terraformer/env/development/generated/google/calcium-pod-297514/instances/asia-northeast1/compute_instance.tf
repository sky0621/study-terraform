resource "google_compute_instance" "tfer--test-002D-service-002D-vm" {
  boot_disk {
    auto_delete = "true"
    device_name = "persistent-disk-0"
    mode        = "READ_WRITE"
    source      = "https://www.googleapis.com/compute/v1/projects/calcium-pod-297514/zones/asia-northeast1-a/disks/test-service-vm"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"

  labels = {
    environment = "development"
    service     = "test-service"
  }

  machine_type = "f1-micro"
  name         = "test-service-vm"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/calcium-pod-297514/global/networks/default"
    network_ip         = "10.146.0.6"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/calcium-pod-297514/regions/asia-northeast1/subnetworks/default"
    subnetwork_project = "calcium-pod-297514"
  }

  project = "calcium-pod-297514"

  scheduling {
    automatic_restart   = "true"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  zone = "asia-northeast1-a"
}
