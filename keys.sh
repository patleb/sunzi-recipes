if aptitude search '~i ^jq$' | grep -q jq; then
  echo "jq already installed, skipping."
else
  sudo apt-get install -y jq
fi

keys=$(jq -r .[] attributes/keys)

for key in "${keys[@]}"; do
  grep -q -F "${key}" /root/.ssh/authorized_keys || echo "${key}" >> /root/.ssh/authorized_keys
done
