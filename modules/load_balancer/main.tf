# Healthcheck for LB
resource "google_compute_health_check" "lb_hc" {
  name = "${var.environment}-http-lb-hc"

  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  timeout_sec         = 5

  http_health_check {
    port               = 80
    request_path       = "/"
    port_specification = "USE_FIXED_PORT"
  }
}

# Backend service for LB
resource "google_compute_backend_service" "lb_bs" {
  name                  = "${var.environment}-web-bs"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_name             = "http"
  protocol              = "HTTP"
  session_affinity      = "NONE"
  timeout_sec           = 30

  backend {
    group           = var.instace_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
    max_utilization = 0.8
  }

  health_checks = [google_compute_health_check.lb_hc.id]

}

# URL map for LB (name of the LB)
resource "google_compute_url_map" "lb_url_map" {
  name            = "${var.environment}-web-lb-map"
  default_service = google_compute_backend_service.lb_bs.id
}

# Target proxies for LB
resource "google_compute_target_http_proxy" "lb_target_proxy" {
  name    = "${var.environment}-tp-lb-http"
  url_map = google_compute_url_map.lb_url_map.id
}

# Forwarding rules for LB
resource "google_compute_global_forwarding_rule" "lb_fwr" {
  name                  = "${var.environment}-fwr-lb-http"
  target                = google_compute_target_http_proxy.lb_target_proxy.id
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_address            = var.static_ip
}