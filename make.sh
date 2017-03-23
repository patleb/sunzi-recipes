
if aptitude search '~i ^make$' | grep -q make; then
  echo "make already installed, skipping."
else
  apt-get -y install make
fi
