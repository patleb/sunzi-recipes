if aptitude search '~i ^libpq-dev$' | grep -q libpq-dev; then
  echo "libpq-dev already installed, skipping."
else
  apt-get -y install libpq-dev
fi
