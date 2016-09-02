# Installs the mysql client lib.

if aptitude search '~i ^libmysqlclient-dev$' | grep -q libmysqlclient-dev; then
  echo "libmysqlclient-dev already installed, skipping."
else
  apt-get -y install libmysqlclient-dev
fi
