variable "project_id" {
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

variable "GOOGLE_CREDENTIALS" {
  description = "Base64 encoded Google Cloud service account credentials."
  type        = string
  sensitive   = true
}

# variable "name" {
#     type = string
# }

# variable "location" {
#     type = string
# }

# variable "force_destroy" {
#     type = bool
# }

# variable "storage_class" {
#     type = string
# }

variable "buckets" {
  type = list(object({
    name          = string
    location      = string
    force_destroy = bool
    storage_class = string
  }))
}