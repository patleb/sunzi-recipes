if aptitude search '~i ^redis-server$' | grep -q redis-server; then
  echo "redis-server already installed, skipping."
else
  apt-get -y install python-software-properties software-properties-common
  apt-add-repository ppa:chris-lea/redis-server
  apt-get update

  apt-get -y install redis-server
fi

# redis configuration
rm /etc/redis/redis.conf
mv files/redis.conf /etc/redis/redis.conf
# upstart supervisor
update-rc.d redis-server disable # disable init.d script for redis
mv files/redis-upstart.conf /etc/init/redis-server.conf
chown redis:root /etc/init/redis-server.conf
# inspeqtor config
mkdir -p /etc/inspeqtor/services.d
mv files/redis-inspeqtor.inq /etc/inspeqtor/services.d/redis-server.inq

initctl reload-configuration

if pgrep "redis-server" > /dev/null; then
  echo "Redis running, restarting."
  restart redis-server
else
  echo "Starting redis."
  start redis-server
fi
