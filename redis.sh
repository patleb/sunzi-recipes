if aptitude search '~i ^redis-server$' | grep -q redis-server; then
  echo "redis-server already installed, skipping."
else
  apt-get -y install python-software-properties
  apt-add-repository ppa:chris-lea/redis-server
  apt-get update

  apt-get -y install redis-server
fi

rm /etc/redis/redis.conf
mv files/redis.conf /etc/redis/redis.conf

service redis-server restart
