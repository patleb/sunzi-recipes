if [ ! -d "/opt/uchiwa" ]; then
  wget -q http://dl.bintray.com/palourde/uchiwa/uchiwa_0.16.0-1_amd64.deb
  dpkg -i uchiwa_0.16.0-1_amd64.deb
else
  echo "uchiwa already installed, skipping."
fi

cp files/sensu-uchiwa.conf /etc/sensu/uchiwa.json

update-rc.d uchiwa defaults
service uchiwa start