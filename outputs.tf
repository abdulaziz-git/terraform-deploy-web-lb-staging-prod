output "load_balancer_static_ip" {
  value = module.network.lb_static_ip
}

output "job_vm_public_ip" {
  value = module.job_server.job_vm_public_ip
}