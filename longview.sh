if aptitude search '~i ^curl$' | grep -q curl; then
  echo "curl already installed, skipping."
else
  apt-get -y install curl
fi

curl -s "https://lv.linode.com/$(cat attributes/longview_key)" | sudo bash
