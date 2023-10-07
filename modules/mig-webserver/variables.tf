variable "environment" {
  description = "The environment (staging or production)."
}

variable "zone" {
  description = "The default zone"
}

variable "network_name" {
  description = "VPC Network name"
}

variable "subnet_name" {
  description = "Subnet name"
}

variable "name_prefix" {
  type        = string
  default     = "template-"
  description = "Name prefix for instance template name"
}

variable "machine_type" {
  type = map(any)
  default = {
    "staging"    = "e2-medium"
    "production" = "e2-standard-2"
  }
  description = "Default machine type for Staging or Production"
}

variable "instance_count" {
  description = "The number of instances creating for the instance group"
}