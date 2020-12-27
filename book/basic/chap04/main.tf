data "google_compute_zones" "available" {
  region = "asia-northeast1"
  status = "UP"
}

variable "compute_instance_zone" {
  description = "A zone used in compute instance"
  type = string
  default = "asia-northeast1-a"

  validation {
    condition = contains(["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"], var.compute_instance_zone)
    error_message = "The compute_instance_zone must be in asia-northeast1 region."
  }
}

resource "google_compute_instance" "default" {
  description = "aaaa"
  name = "test-${count.index}"
  machine_type = "f1-micro"
  zone = data.google_compute_zones.available.names[count.index]

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

  count = length(data.google_compute_zones.available.names)
}

output "cpu_platform" {
  description = "CPU platform of the instance"
  value = google_compute_instance.default[*].cpu_platform
}

output "instance_names" {
  description = "Names of instances"
  value = google_compute_instance.default[*].name
}

output "instance_zones" {
  description = "Zone of instances"
  value = google_compute_instance.default[*].zone
}
