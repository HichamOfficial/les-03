# Les 03 — Infra + Ansible

Dit project hoort bij Week 4. Hierin maak ik een test-VM met Terraform en gebruik ik Ansible om ermee te praten.

## Terraform
- `cd terraform`
- `terraform init`
- `terraform apply -auto-approve`
- Daarna staat de VM klaar en wordt automatisch een `inventory.ini` gemaakt voor Ansible.

## Ansible
- Test verbinding:  
  ```bash
  ansible -i inventory.ini all -m ping
