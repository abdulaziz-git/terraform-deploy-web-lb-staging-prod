# Instance Template
resource "google_compute_instance_template" "lb" {
  name_prefix  = "${var.environment}-${var.name_prefix}"
  machine_type = var.machine_type[var.environment]

  disk {
    source_image = "debian-cloud/debian-11"
    boot         = true
    auto_delete  = true
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    startup-script = "#! /bin/bash\n     sudo apt-get update\n     sudo apt-get install apache2 -y\n    vm_hostname=\"$(curl -H \"Metadata-Flavor:Google\" \\\n   http://169.254.169.254/computeMetadata/v1/instance/name)\"\n   sudo echo \"Page served from: $vm_hostname\" | \\\n   tee /var/www/html/index.html\n   sudo systemctl restart apache2"
  }

  tags = ["allow-hc", "allow-ssh-iap"]

  lifecycle {
    create_before_destroy = true
  }
}

# MIG
resource "google_compute_instance_group_manager" "lb" {
  name               = substr("${var.environment}-mig-${md5(google_compute_instance_template.lb.name)}", 0, 20)
  zone               = var.zone
  base_instance_name = "${var.environment}-web-server"
  target_size        = var.instance_count

  version {
    instance_template = google_compute_instance_template.lb.id
  }

  named_port {
    name = "http"
    port = 80
  }

}