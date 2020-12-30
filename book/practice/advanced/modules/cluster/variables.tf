variable "service_name" {
  description = "A service name of the service"
  type = string
}

variable "env" {
  description = "Environment of the microservice"
  type = string

  validation {
    condition = contains(["dev", "prd"], var.env)
    error_message = "The environment must be dev or prd."
  }
}

variable "gcp_region" {
  description = "GCP region"
  type = string
  default = "asia-northeast1"
}

variable "gcp_additional_enabled_services" {
  description = "Additional GCP API services to be enabled per project"
  type = list(string)
  default = []
}

variable "service_viewers" {
  description = "Viewers of the microservice"
  type = list(string)
  default = []
}

variable "service_admins" {
  description = "Admins of the microservice"
  type = list(string)
  default = []
}
