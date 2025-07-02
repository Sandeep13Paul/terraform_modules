#!/bin/bash

echo "[Atlantis] Fetching VM IPs from Terraform output..."
cd project1
terraform output -json vm_public_ips > vm_ips.json

cd ../ansible

rm -f inventory

echo "[web]" > inventory

for ip in $(jq -r '.[]' vm_ips.json); do
    echo "$ip ansible_ssh_private_key_file=~/.ssh/gcp_ssh" >> inventory
done

ansible-playbook -i inventory main.yml