terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source      = "./modules/network"
  environment = var.environment
}

module "mig-webserver" {
  source         = "./modules/mig-webserver"
  environment    = var.environment
  zone           = var.zone
  network_name   = module.network.network_name
  subnet_name    = module.network.subnet_name
  instance_count = var.instance_count
}

module "load_balancer" {
  source        = "./modules/load_balancer"
  environment   = var.environment
  static_ip     = module.network.lb_static_ip
  instace_group = module.mig-webserver.instace_group
}

module "job_server" {
  source       = "./modules/job_server"
  environment  = var.environment
  zone         = var.zone
  network_name = module.network.network_name
  subnet_name  = module.network.subnet_name
}