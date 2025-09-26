output "web_ips" {
  description = "IP-adressen van de webservers (web-1 en web-2)"
  value       = [for i in esxi_guest.web : i.ip_address]
}

output "db_ip" {
  description = "IP-adres van de database server (db-1)"
  value       = esxi_guest.db.ip_address
}

resource "local_file" "ansible_inventory" {
  filename = "inventory/hosts.ini"
  content  = <<EOT
[web]
%{ for ip in esxi_guest.web[*].ip_address ~}
${ip}
%{ endfor }

[db]
${esxi_guest.db.ip_address}
EOT

  depends_on = [
    esxi_guest.web,
    esxi_guest.db
  ]
}
