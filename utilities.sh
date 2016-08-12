if aptitude search '~i ^vim$' | grep -q vim; then
  echo "vim already installed, skipping."
else
  apt-get -y install vim
fi

if aptitude search '~i ^mosh$' | grep -q mosh; then
  echo "mosh already installed, skipping."
else
  apt-get -y install mosh
fi

if aptitude search '~i ^sysdig$' | grep -q sysdig; then
  echo "mosh already installed, skipping."
else
  curl -s https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public | apt-key add -
  curl -s -o /etc/apt/sources.list.d/draios.list http://download.draios.com/stable/deb/draios.list
  apt-get update
  apt-get -y install linux-headers-$(uname -r)
  apt-get -y install sysdig
fi
