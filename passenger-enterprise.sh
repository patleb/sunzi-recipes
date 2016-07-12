download_token=$(cat attributes/passenger_enterprise_download_token)

if aptitude search '~i ^passenger-enterprise$' | grep -q passenger-enterprise; then
  echo "passenger-enterprise already installed, skipping."
else
  mv files/passenger-enterprise-license /etc/passenger-enterprise-license
  chmod 644 /etc/passenger-enterprise-license

  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
  sudo apt-get install -y apt-transport-https ca-certificates
  sudo sh -c 'echo deb https://download:${download_token}@www.phusionpassenger.com/enterprise_apt trusty main > /etc/apt/sources.list.d/passenger.list'
  sudo apt-get update
  sudo apt-get install -y nginx-extras passenger-enterprise
fi

sudo service nginx restart
sudo /usr/bin/passenger-config validate-install
