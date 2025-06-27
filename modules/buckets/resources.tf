# resource "google_storage_bucket" "bucket_sandeep" {
#   count         = length(var.buckets)
#   name          = var.buckets[count.index].name
#   location      = var.buckets[count.index].location
#   force_destroy = var.buckets[count.index].force_destroy
#   storage_class = var.buckets[count.index].storage_class
#   labels = {
#     "dep" = "compliance"
#   }

#   lifecycle_rule {
#     condition {
#         age = 5
#     }
#     action {
#         type = "SetStorageClass"
#         storage_class = "COLDLINE"
#     }
#   }
# }

# resource "google_storage_bucket_object" "object-sandeep" {
#     count  = length(var.buckets)
#     name = "iphone_logo"
#     bucket = google_storage_bucket.bucket_sandeep[count.index].name
#     source = "../modules/buckets/p2.jpg"
# }

resource "google_storage_bucket" "bucket_sandeep" {
  for_each      = { for b in var.buckets : b.name => b }

  name          = each.value.name
  location      = each.value.location
  force_destroy = each.value.force_destroy
  storage_class = each.value.storage_class

  labels = {
    "dep" = "compliance"
  }

  lifecycle_rule {
    condition {
      age = 5
    }
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }
}

resource "google_storage_bucket_object" "object_sandeep" {
  for_each = { for b in var.buckets : b.name => b }

  name   = "iphone_logo"
  bucket = google_storage_bucket.bucket_sandeep[each.key].name
  source = "../modules/buckets/p2.jpg"
}