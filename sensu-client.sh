/etc/init.d/sensu-client stop || true

echo "Checking if sensu is installed"
if aptitude search '~i ^sensu$' | grep -q sensu; then
  echo "sensu already installed, skipping."
else
  wget -q http://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | sudo apt-key add -
  echo "deb     http://sensu.global.ssl.fastly.net/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list

  apt-get update
  apt-get -y install sensu
fi

mkdir -p /etc/sensu/conf.d

sensu_host=$(cat attributes/sensu_host)
sensu_port=$(cat attributes/sensu_port)
sensu_password=$(cat attributes/sensu_password)
cat >/etc/sensu/conf.d/redis.json <<EOL
{
  "redis": {
    "host": "${sensu_host}",
    "port": ${sensu_port},
    "password": "${sensu_password}",
    "auto_reconnect": true
  }
}
EOL

cat >/etc/sensu/conf.d/transport.json <<EOL
{
  "transport": {
    "name": "redis",
    "reconnect_on_error": true
  }
}
EOL

cp files/sensu-client.json /etc/sensu/conf.d/client.json

update-rc.d sensu-client defaults
/etc/init.d/sensu-client start
