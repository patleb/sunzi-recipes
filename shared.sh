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