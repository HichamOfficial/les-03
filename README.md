# Les 03 — Infra + Ansible

## Opdracht 1

### Terraform
- `cd terraform`
- `terraform init`
- `terraform apply -auto-approve`
- Daarna staat de VM klaar en wordt automatisch een `inventory.ini` gemaakt voor Ansible.

### Ansible
- Test verbinding:  
  ```bash
  ansible -i inventory.ini all -m ping

## Opdracht 2
Run het playbook:
```bash
ansible-playbook -i inventory.ini
```
De output van deze commando kan je vinden in [inventory.ini](inventory.ini).

