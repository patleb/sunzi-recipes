if aptitude search '~i ^passenger$' | grep -q passenger; then
  echo "passenger already installed, skipping."
else
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
  sudo apt-get install -y apt-transport-https ca-certificates
  sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
  sudo apt-get update
  sudo apt-get install -y nginx-extras passenger
fi

sudo service nginx restart
sudo /usr/bin/passenger-config validate-install
