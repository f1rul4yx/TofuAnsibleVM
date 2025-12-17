##############################################
# escenario.tf — Escenario VPN Acceso Remoto
##############################################

locals {

  ##############################################
  # Redes a crear
  ##############################################

  networks = {
    red-nat = {
      name      = "red-nat"
      mode      = "nat"
      addresses = ["192.168.100.0/24"]
      bridge    = "br-nat"
      dhcp      = true
      dns       = true
      autostart = true
    }

    red-1 = {
      name      = "red-1"
      mode      = "none"
      bridge    = "br-1"
      autostart = true
    }

    red-2 = {
      name      = "red-2"
      mode      = "none"
      bridge    = "br-2"
      autostart = true
    }

    red-3 = {
      name      = "red-3"
      mode      = "none"
      bridge    = "br-3"
      autostart = true
    }
  }

  ##############################################
  # Máquinas virtuales a crear
  ##############################################

  servers = {
    server1 = {
      name       = "cliente"
      memory     = 1024
      vcpu       = 1
      base_image = "debian-13-generic-amd64.qcow2"

      networks = [
        { network_name = "red-nat", wait_for_lease = true },
        { network_name = "red-1" }
      ]

      user_data      = "${path.module}/cloud-init/server1/user-data.yaml"
      network_config = "${path.module}/cloud-init/server1/network-config.yaml"
    }

    server2 = {
      name       = "router"
      memory     = 1024
      vcpu       = 1
      base_image = "debian-13-generic-amd64.qcow2"

      networks = [
        { network_name = "red-nat", wait_for_lease = true },
        { network_name = "red-1" },
        { network_name = "red-2" }
      ]

      user_data      = "${path.module}/cloud-init/server2/user-data.yaml"
      network_config = "${path.module}/cloud-init/server2/network-config.yaml"
    }

    server3 = {
      name       = "vpn"
      memory     = 1024
      vcpu       = 1
      base_image = "debian-13-generic-amd64.qcow2"

      networks = [
        { network_name = "red-nat", wait_for_lease = true },
        { network_name = "red-2" },
        { network_name = "red-3" }
      ]

      user_data      = "${path.module}/cloud-init/server3/user-data.yaml"
      network_config = "${path.module}/cloud-init/server3/network-config.yaml"
    }

    server4 = {
      name       = "maquina-interna"
      memory     = 1024
      vcpu       = 1
      base_image = "debian-13-generic-amd64.qcow2"

      networks = [
        { network_name = "red-nat", wait_for_lease = true },
        { network_name = "red-3" }
      ]

      user_data      = "${path.module}/cloud-init/server4/user-data.yaml"
      network_config = "${path.module}/cloud-init/server4/network-config.yaml"
    }
  }
}
