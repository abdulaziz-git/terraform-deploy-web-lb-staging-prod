output "network_name" {
  value = google_compute_network.lb.name
}

output "subnet_name" {
  value = google_compute_subnetwork.lb.name
}

output "fw_allow_hc" {
  value = google_compute_firewall.fw_allow_hc.id
}

output "fw_allow_ssh_iap" {
  value = google_compute_firewall.fw_allow_ssh_iap.id
}

output "lb_static_ip" {
  value = google_compute_global_address.lb_ip.address
}