locals {
  name_suffix = "example"
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "location" {
  description = "The location for the GCS bucket"
  type        = string
}

resource "google_storage_bucket" "default" {
  name     = "my-bucket-${local.name_suffix}-${var.location}"
  location = var.location
  project  = var.project_id

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion
  }
}

resource "google_pubsub_topic" "default" {
  name    = "my-topic-${local.name_suffix}"
  project = var.project_id
}

output "bucket_name" {
  value = google_storage_bucket.default.name
}

output "pubsub_topic_name" {
  value = google_pubsub_topic.default.name
}
