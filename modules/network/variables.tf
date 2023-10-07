variable "environment" {
  description = "The environment (staging or production)."
}

variable "cidr_range" {
  type        = map(any)
  description = "IP address ranges for subnet"
  default = {
    "staging"    = "172.16.1.0/24"
    "production" = "10.0.1.0/24"
  }
}