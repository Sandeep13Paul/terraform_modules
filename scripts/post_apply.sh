#!/bin/bash
set -e
set -x

echo "[Atlantis] Running post-apply script..."

# apk update
# apk add ansible jq openssh python3

# cd project_1

echo "[Atlantis] Fetching VM IPs from Terraform output..."
terraform output -json vm_public_ips > ../vm_ips.json

cd ../ansible

rm -f inventory.txt

echo "[web]" > inventory.txt

SSH_KEY_PATH="/home/atlantis/.atlantis/repos/Sandeep13Paul/ssh_key"
chmod 600 "$SSH_KEY_PATH"

mkdir -p ~/.ssh
touch ~/.ssh/known_hosts

for ip in $(jq -r '.[]' ../vm_ips.json); do
  [ -f ~/.ssh/known_hosts ] && ssh-keygen -R "$ip" || true
  echo "$ip ansible_user=sandeeppaul ansible_ssh_private_key_file=$SSH_KEY_PATH ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> inventory.txt
done

echo "[Atlantis] Generated inventory:"
cat inventory.txt

echo "[Atlantis] Running Ansible playbook..."
ssh-keygen -R 34.142.238.164
ansible-playbook -i inventory.txt main.yml
