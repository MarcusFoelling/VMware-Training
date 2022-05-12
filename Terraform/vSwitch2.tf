provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "ICM-Datacenter"
}

data "vsphere_host" "host" {
  name          = "sa-esxi-01.vclass.local"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_host_virtual_switch" "switch" {
  name           = "vSwitch2"
  host_system_id = "${data.vsphere_host.host.id}"

  network_adapters = ["vmnic2"]

  active_nics  = ["vmnic2"]
  standby_nics = []
}

resource "vsphere_host_port_group" "pg" {
  name                = "vMotion"
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
}

resource "vsphere_vnic" "v1" {
  host      = "${data.vsphere_host.host.id}"
  portgroup = vsphere_host_port_group.pg.name
  ipv4 {
    dhcp = true
  }
}