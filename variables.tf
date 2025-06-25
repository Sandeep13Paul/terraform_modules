variable "project_id_1" {
  description = "The ID of the project in which the resources will be created."
  type        = string
}

variable "project_id_2" {
  description = "The ID of the project in which the resources will be created."
  type        = string
}

variable "region" {
  description = "The region in which the resources will be created."
  type        = string
}

variable "zone" {
  description = "The zone in which the resources will be created."
  type        = string
}

variable "GOOGLE_CREDENTIALS1" {
  description = "Base64 encoded Google Cloud service account credentials."
  type        = string
  sensitive   = true
}

variable "GOOGLE_CREDENTIALS2" {
  description = "Base64 encoded Google Cloud service account credentials."
  type        = string
  sensitive   = true
}

variable "enable_vm" {
  type    = bool
  default = false
}

variable "enable_vpc" {
  type    = bool
  default = false
}

variable "enable_storage" {
  type    = bool
  default = false
}

variable "enable_service_account" {
  type    = bool
  default = false
}

variable "project_selector" {
  description = "Choose which GCP project to use: project1 or project2"
  type        = string
}

variable "services" {
  type = map(any)
}