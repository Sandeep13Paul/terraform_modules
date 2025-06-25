resource "google_storage_bucket" "bucket-sandeep" {
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
  labels = {
    "dep" = "compliance"
  }

  lifecycle_rule {
    condition {
        age = 5
    }
    action {
        type = "SetStorageClass"
        storage_class = "COLDLINE"
    }
  }
}

resource "google_storage_bucket_object" "object-sandeep" {
    name = "iphone_logo"
    bucket = google_storage_bucket.bucket-sandeep.name
    source = "./modules/buckets/p2.jpg"
}

# resource "random_id" "suffix" {
#   byte_length = 4
# }