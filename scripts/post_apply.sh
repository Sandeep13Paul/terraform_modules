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
# chmod 600 "$SSH_KEY_PATH"

mkdir -p ~/.ssh
touch ~/.ssh/known_hosts

for ip in $(jq -r '.[]' ../vm_ips.json); do
  echo "[Atlantis] Waiting for SSH to become available on $ip..."
  for i in {1..12}; do  # Wait up to 60 seconds (12 * 5s)
    if ssh -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no -o ConnectTimeout=5 sandeeppaul@$ip "echo SSH ready" >/dev/null 2>&1; then
      echo "[Atlantis] SSH is ready on $ip"
      break
    else
      echo "[Atlantis] SSH not ready on $ip, retrying in 5 seconds..."
      sleep 5
    fi
  done

  ssh-keygen -R "$ip" || true
  echo "$ip ansible_user=sandeeppaul ansible_ssh_private_key_file=\"$SSH_KEY_PATH\" ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> inventory.txt
done

echo "[Atlantis] Generated inventory:"
cat inventory.txt

echo "[Atlantis] Running Ansible playbook..."
ssh-keygen -R 34.142.238.164
ansible-playbook -i inventory.txt main.yml


#!/bin/bash
# set -e
# set -x

# echo "[Atlantis] Running post-apply script..."

# echo "[Atlantis] Fetching VM IPs from Terraform output..."
# terraform output -json vm_public_ips > ../vm_ips.json

# cd ../ansible

# rm -f inventory.txt
# echo "[web]" > inventory.txt

# SSH_KEY_PATH="/home/atlantis/.atlantis/repos/Sandeep13Paul/ssh_key"

# for ip in $(jq -r '.[]' ../vm_ips.json); do
#   echo "[Atlantis] Checking SSH availability on $ip..."

#   # Wait for SSH port 22 to be open (up to 60 seconds)
#   for i in {1..12}; do
#     if nc -z -w3 "$ip" 22 2>/dev/null; then
#       echo "[Atlantis] SSH is available on $ip"
#       break
#     else
#       echo "[Atlantis] SSH not ready on $ip, retrying in 5 seconds..."
#       sleep 5
#     fi
#   done

#   # Add to known_hosts (optional - suppress errors if not found)
#   ssh-keygen -R "$ip" || true

#   # Write inventory line
#   echo "$ip ansible_user=sandeeppaul ansible_ssh_private_key_file=$SSH_KEY_PATH ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> inventory.txt
# done

# echo "[Atlantis] Generated inventory:"
# cat inventory.txt

# echo "[Atlantis] Running Ansible playbook..."
# ansible-playbook -i inventory.txt main.yml
