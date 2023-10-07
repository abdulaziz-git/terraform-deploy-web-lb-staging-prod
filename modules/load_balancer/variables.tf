variable "environment" {
  description = "The environment (staging or production)."
}

variable "static_ip" {
  description = "Global static IP for Load Balancer"
}

variable "instace_group" {
  description = "Managed instance group"
}