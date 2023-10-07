# Custom VPC Network for LB
resource "google_compute_network" "lb" {
  name                    = "${var.environment}-vpc"
  auto_create_subnetworks = false
}

# Subnet for LB
resource "google_compute_subnetwork" "lb" {
  name          = "${var.environment}-subnet"
  ip_cidr_range = var.cidr_range[var.environment]
  network       = google_compute_network.lb.name
}

# Firewall rules for LB
resource "google_compute_firewall" "fw_allow_hc" {
  name      = "${var.environment}-fw-allow-hc"
  network   = google_compute_network.lb.name
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-hc"]
}
# Allow SSH access from IAP
resource "google_compute_firewall" "fw_allow_ssh_iap" {
  name      = "${var.environment}-fw-allow-ssh-iap"
  network   = google_compute_network.lb.name
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-ssh-iap"]
}

# Static IP for LB
resource "google_compute_global_address" "lb_ip" {
  name       = "${var.environment}-lb-static-ip"
  ip_version = "IPV4"
}