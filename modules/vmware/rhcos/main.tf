resource "vsphere_virtual_machine" "vm" {

  name               = var.name
  resource_pool_id   = var.resource_pool_id
  datastore_id       = var.datastore
  num_cpus           = var.num_cpu
  memory             = var.memory
  memory_reservation = var.memory
  guest_id           = var.guest_id
  folder             = var.folder
  enable_disk_uuid   = "true"

  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  network_interface {
    network_id     = var.network
    adapter_type   = var.adapter_type
    use_static_mac = true
    mac_address    = var.mac_address
  }

  disk {
    label            = "disk0"
    size             = var.disk_size
    thin_provisioned = var.thin_provisioned
  }

  clone {
    template_uuid = var.template
  }

  extra_config = {
    "guestinfo.ignition.config.data"          = base64encode(var.ignition)
    "guestinfo.ignition.config.data.encoding" = "base64"
  }

  # Despite the warnings against using extra_config by Hashicorp, vapp props
  # are limited to the length they can accept and are not suitable for Openshift 4.
  # vapp {
  #   properties = {
  #     "guestinfo.ignition.config.data"          = base64encode(var.ignition)
  #     "guestinfo.ignition.config.data.encoding" = "base64"
  #   }
  # }

}
