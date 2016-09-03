# Installs passenger enterprise.
#
# Required Files
#
# - passenger/enterprise-license
#
# Required Attributes
#
# - passenger_enterprise_download_token [String] the download token

if aptitude search '~i ^passenger-enterprise$' | grep -q passenger-enterprise; then
  echo "passenger-enterprise already installed, skipping."
else
  mv files/passenger/enterprise-license /etc/passenger-enterprise-license
  chown root /etc/passenger-enterprise-license
  chmod 644 /etc/passenger-enterprise-license
  
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
  apt-get install -y apt-transport-https ca-certificates

  # Add our APT repository
  unset HISTFILE
  sh -c 'echo deb https://download:<%= @attributes.passenger_enterprise_download_token %>@www.phusionpassenger.com/enterprise_apt trusty main > /etc/apt/sources.list.d/passenger.list'
  chown root: /etc/apt/sources.list.d/passenger.list
  chmod 600 /etc/apt/sources.list.d/passenger.list
  apt-get update

  # Install Passenger Enterprise + Nginx
  apt-get install -y nginx-extras passenger-enterprise
fi

service nginx restart
/usr/bin/passenger-config validate-install
