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