variable "gke_project" {
  description = "Name of GKE project"
  type        = string
}

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

variable "cluster_tfstate_bucket" {
  type = string
  description = "GCS bucket for Kubernetes cluster terraform state"
}

variable "cluster_tfstate_prefix" {
  type = string
  description = "GCS prefix for Kubernetes cluster terraform state"
}
