##############################################
# escenario.tf — Escenario de ejemplo
##############################################

locals {

  ##############################################
  # Redes a crear
  ##############################################

  networks = {
    red-nat = {
      name      = "red-nat"
      mode      = "nat"
      domain    = "example.algo"
      addresses = ["192.168.100.0/24"]
      bridge    = "br-nat"
      dhcp      = true
      dns       = true
      autostart = true
    }

    red-aislada = {
      name      = "red-aislada"
      mode      = "none"
      addresses = ["192.168.200.0/24"]
      bridge    = "br-aislada"
      autostart = true
    }

    red-muy-aislada = {
      name      = "red-muy-aislada"
      mode      = "none"
      bridge    = "br-muy-aislada"
      autostart = true
    }
  }

  ##############################################
  # Máquinas virtuales a crear
  ##############################################

  servers = {
    server1 = {
      name       = "name"
      memory     = 1024
      vcpu       = 1
      base_image = "debian-13-generic-amd64.qcow2"

      # Descargar imágenes qcow2 base de:
      #   - https://cloud.debian.org/images/cloud/
      #   - https://cloud-images.ubuntu.com/
      # Meterlas en /var/lib/libvirt/images/ con permisos 644

      networks = [
        { network_name = "red-nat", wait_for_lease = true },
        { network_name = "red-aislada" }
      ]

      user_data      = "${path.module}/cloud-init/server1/user-data.yaml"
      network_config = "${path.module}/cloud-init/server1/network-config.yaml"
    }
  }
}
