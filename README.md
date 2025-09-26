# Les 03 — Infra + Ansible

## Opdracht 1

### Terraform
- `cd terraform`
- `terraform init`
- `terraform apply -auto-approve`
Daarna staat de VM klaar en wordt automatisch een [inventory.ini](inventory.ini) gemaakt voor Ansible.

### Ansible-test verbinding
  ```bash
  ansible -i inventory.ini all -m ping
````

## Opdracht 2
```
mkdir -p outputs
ansible-playbook -i inventory.ini playbooks/02_variables.yml | tee outputs/opdracht2-run1.txt
ansible-playbook -i inventory.ini playbooks/02_variables.yml | tee outputs/opdracht2-run2.txt
```
### Extra bewijs (inhoud wegschrijven)
```
ansible -i inventory.ini all -a "cat /etc/motd"       | tee outputs/opdracht2-motd.txt
ansible -i inventory.ini all -a "cat /tmp/facts.txt"  | tee outputs/opdracht2-facts.txt
ansible -i inventory.ini all -a "cat /tmp/kernel.txt" | tee outputs/opdracht2-kernel.txt
```
 
Run 1: [opdracht2-run1.txt](outputs/opdracht2-run1.txt)

Run 2: [opdracht2-run1.txt](outputs/opdracht2-run1.txt) 

MOTD: [opdracht2-motd.txt](outputs/opdracht2-motd.txt) 

Facts: [opdracht2-facts.txt](outputs/opdracht2-facts.txt)

Kernel: [opdracht2-kernel.txt](outputs/opdracht2-kernel.txt)

