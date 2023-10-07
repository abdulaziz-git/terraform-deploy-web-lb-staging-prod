resource "google_compute_instance" "vm" {
  name         = "${var.environment}-job"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {
      # This is to set instance Ephemeral public IP
    }
  }

  tags = ["allow-ssh-iap"]

  metadata = {
    # Metadata to running specific job using startup script
  }

  allow_stopping_for_update = true

  scheduling {
    preemptible                 = true
    automatic_restart           = false
    provisioning_model          = "SPOT"
    instance_termination_action = "STOP"
  }
}