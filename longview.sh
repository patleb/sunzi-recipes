if aptitude search '~i ^curl$' | grep -q curl; then
  echo "curl already installed, skipping."
else
  apt-get -y install curl
fi

longview_key=$(cat attributes/longview_key)
if grep -Fxq "$longview_key" "/etc/linode/longview.key"; then
  echo "Longview is setup with the correct key, skipping installation"
else
  echo "Installing longview from https://lv.linode.com/$(cat attributes/longview_key)"
  curl -s "https://lv.linode.com/$(cat attributes/longview_key)" | sudo bash
fi
