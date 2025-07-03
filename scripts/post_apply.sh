#!/bin/bash

echo "[Atlantis] Running post-apply script..."

cd project_1

echo "[Atlantis] Fetching VM IPs from Terraform output..."
terraform output -json vm_public_ips > vm_ips.json

cd ../ansible

rm -f inventory.txt

echo "[web]" > inventory.txt

for ip in $(jq -r '.[]' /vm_ips.json); do
  echo "$ip ansible_ssh_private_key_file='../../../ssh_key'" >> inventory.txt
done

echo "[Atlantis] Generated inventory:"
cat inventory.txt

echo "[Atlantis] Running Ansible playbook..."
ansible-playbook -i inventory.txt playbook.yml
rm /tmp/temp_gcp_key
