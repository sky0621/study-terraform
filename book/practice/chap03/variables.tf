variable "project" {
  description = "A name of a GCP project"
  type = string
  default = null
}

variable "compute_instance_region" {
  description = "A region to use the module"
  type = string
  default = "asia-northeast1"

  validation {
    condition = var.compute_instance_region == "asia-northeast1"
    error_message = "The region must be asia-northeast1."
  }
}

variable "compute_instance_zone" {
  description = "A zone used in a compute instance"
  type = string
  default = "asia-northeast1-a"

  validation {
    condition = contains(["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"], var.compute_instance_zone)
    error_message = "The zone must be in asia-northeast1 region."
  }
}
