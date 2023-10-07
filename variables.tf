variable "project_id" {
  type    = string
  default = "labs-a-375306"
}

variable "region" {
  type    = string
  default = "asia-southeast2"
}

variable "zone" {
  type    = string
  default = "asia-southeast2-b"
}

variable "environment" {
  type        = string
  description = "Please input the environment either `staging` or `production`."
}

variable "instance_count" {
  type        = number
  default     = 3
  description = "The number of instances creating for the instance group"
}
