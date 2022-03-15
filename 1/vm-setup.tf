terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}
resource "virtualbox_vm" "node" {
  count     = 1
  name      = "ubuntu-2004-vm"
  image     = "https://app.vagrantup.com/generic/boxes/ubuntu2004/versions/3.6.10/providers/virtualbox.box"
  cpus      = 2
  memory    = "4096 mib"

  network_adapter {
    type           = "nat"
    host_interface = "vboxnet1"
  }
}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
}
