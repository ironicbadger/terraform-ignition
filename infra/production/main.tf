module "lb" {
  source        = "../../modules/ign_haproxy"
  lb_ip_address = var.loadbalancer_ip

  api_backend_addresses = flatten([
    var.bootstrap_ip,
    var.master_ips]
  )
  ingress = var.worker_ips
}

module "lb_vm" {
  source           = "../../modules/rhcos"
  count            = length(var.loadbalancer_mac)
  name             = "prod-lb-example"
  folder           = "awesomo/redhat"
  datastore        = data.vsphere_datastore.nvme500.id
  disk_size        = 16
  memory           = 1024
  num_cpu          = 2
  ignition         = module.lb.ign_haproxy_output
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  datacenter_id    = yamldecode(file("~/.config/ocp/vsphere.yaml"))["vsphere-dc"]
  template         = data.vsphere_virtual_machine.template.id
  thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  network          = data.vsphere_network.network.id
  adapter_type     = data.vsphere_virtual_machine.template.network_interface_types[0]
  mac_address      = var.loadbalancer_mac[count.index]
}

# output "ign" {
#   value = module.lb.ign_haproxy_output
# }