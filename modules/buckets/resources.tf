resource "google_storage_bucket" "bucket-sandeep" {
  count         = length(var.buckets)
  name          = var.buckets[count.index].name
  location      = var.buckets[count.index].location
  force_destroy = var.buckets[count.index].force_destroy
  storage_class = var.buckets[count.index].storage_class
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