locals {
  name_suffix = "example"
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

resource "google_compute_network" "default" {
  name = "test-network-${local.name_suffix}-${var.region}"
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall-${local.name_suffix}"
  network = google_compute_network.default.name
  direction = "INGRESS"
  priority = 1000

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_ranges = ["192.168.1.0/24"]  # Restrict IP range
}
