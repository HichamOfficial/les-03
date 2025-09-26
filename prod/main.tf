terraform {
  required_version = ">= 1.10.3"
  required_providers {
    esxi = {
      source  = "josenk/esxi"
      version = "1.10.3"
    }
  }
}

provider "esxi" {
  esxi_hostname = "192.168.1.60"
  esxi_hostport = "22"
  esxi_hostssl  = "443"
  esxi_username = "root"
  esxi_password = "Welkom01!"
}

locals {
  templatevars = {
    public_key   = var.public_key
    ssh_username = var.ssh_username
  }
}

# -------------------------------------------------------
# 2 webservers: web-1 en web-2
# -------------------------------------------------------
resource "esxi_guest" "web" {
  count      = 2
  guest_name = "web-${count.index + 1}"
  disk_store = var.disk_store
  memsize    = var.memory_mb
  numvcpus   = var.num_cpus
  ovf_source = var.ovf_source

  network_interfaces {
    virtual_network = var.network
  }

  guestinfo = {
    "userdata"          = base64encode(templatefile("${path.module}/userdata.yaml", local.templatevars))
    "userdata.encoding" = "base64"
  }
}

# -------------------------------------------------------
# 1 database server: db-1
# -------------------------------------------------------
resource "esxi_guest" "db" {
  guest_name = "db-1"
  disk_store = var.disk_store
  memsize    = var.memory_mb
  numvcpus   = var.num_cpus
  ovf_source = var.ovf_source

  network_interfaces {
    virtual_network = var.network
  }

  guestinfo = {
    "userdata"          = base64encode(templatefile("${path.module}/userdata.yaml", local.templatevars))
    "userdata.encoding" = "base64"
  }
}
