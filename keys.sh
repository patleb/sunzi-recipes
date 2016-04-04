if aptitude search '~i ^jq$' | grep -q jq; then
  echo "jq already installed, skipping."
else
  sudo apt-get install -y jq
fi

keys=$(jq .[] attributes/keys)

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for key in ${keys[@]}; do
  key="${key%\"}"
  key="${key#\"}"
  echo $key
  echo '-'
  grep -q -F "$key" /root/.ssh/authorized_keys || echo $key >> /root/.ssh/authorized_keys
done
IFS=$SAVEIFS
