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

## Opdracht 3 – Voorwaardelijke taken

In deze opdracht heb ik een playbook gemaakt [03_conditionals.yml](playbooks/03_conditionals.yml) dat afhankelijk van de distributie andere taken uitvoert.

- Als de server **Ubuntu** is, wordt een bericht getoond en wordt een testbestand gemaakt.
- Als de server **Red Hat** zou zijn, wordt een ander bericht getoond.
- Er wordt gecontroleerd of `/etc/hosts` bestaat. De taak kan falen als het bestand er niet is.
- Er is ook een taak die `echo hallo` uitvoert maar **niet** als “changed” wordt gezien.

### Resultaat
- Eerste run: er wordt een testbestand gemaakt en je ziet `changed=1`. Zie [opdracht3-run1.txt](outputs/opdracht3-run1.txt).
- Tweede run: alles is al gedaan, er verandert niks meer en je ziet `changed=0`. Zie [opdracht3-run2.txt](outputs/opdracht3-run2.txt).

## Opdracht 4 — Includes, Imports & Roles

### Werking
In deze opdracht is een nieuw playbook `site.yaml` gemaakt.  
Dit playbook laat zien hoe je taken kunt opsplitsen en hergebruiken:

- **import_tasks**  
  Taken worden al bij het inlezen van het playbook vastgezet.  
  Handig voor statische taken die niet dynamisch hoeven te worden geladen.

- **include_tasks**  
  Taken worden pas geladen tijdens runtime.  
  Handig als je bijvoorbeeld voorwaarden wilt gebruiken (e.g. `when:`) of paden dynamisch wilt bepalen.

Daarnaast is er een nieuwe role `role_firewall` toegevoegd.  
Deze role installeert en configureert UFW en zorgt dat poort **8080** (en SSH) openstaat.

### Waarom roles gebruiken
Roles zorgen ervoor dat je playbooks overzichtelijk blijven:
- Je kunt makkelijk hergebruik maken in meerdere projecten.
- Bestanden worden logisch gestructureerd (`tasks/main.yml`, `vars/`, `templates/`).
- Het wordt eenvoudiger voor teamleden om de playbooks te begrijpen en uit te breiden.

### Testen
Playbook draaien:
```bash
ansible-playbook -i inventory.ini site.yaml
