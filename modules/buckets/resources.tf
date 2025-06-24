resource "google_storage_bucket" "bucket-sandeep" {
  name          = "bucket-${random_id.suffix.hex}"
  location      = var.region
  storage_class = "NEARLINE"
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
    source = "p2.jpg"
}

resource "random_id" "suffix" {
  byte_length = 4
}