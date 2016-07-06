/etc/init.d/sensu-client stop 2>/dev/null
/etc/init.d/sensu-server stop 2>/dev/null
/etc/init.d/sensu-api stop 2>/dev/null

if aptitude search '~i ^sensu$' | grep -q sensu; then
  echo "sensu already installed, skipping."
else
  wget -q http://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | sudo apt-key add -
  echo "deb     http://sensu.global.ssl.fastly.net/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list

  apt-get update

  apt-get -y install sensu
fi

mkdir -p /etc/sensu/conf.d

cp files/sensu-redis.conf /etc/sensu/conf.d/redis.json
cp files/sensu-transport.conf /etc/sensu/conf.d/transport.json
cp files/sensu-client.conf /etc/sensu/conf.d/client.json
cp files/sensu-api.conf /etc/sensu/conf.d/api.json

update-rc.d sensu-client defaults
update-rc.d sensu-server defaults
update-rc.d sensu-api defaults

/etc/init.d/sensu-client start
/etc/init.d/sensu-server start
/etc/init.d/sensu-api start