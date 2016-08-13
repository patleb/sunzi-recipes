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
if [ -f /etc/init.d/redis-server ]; then
  update-rc.d redis-server disable # disable init.d script for redis
  rm -f /etc/init.d/redis-server # Remove the existing init script
fi

# Create the upstart script for redis
cat >/etc/init/redis-server.conf <<EOL
description "redis server"

start on runlevel [23]
stop on shutdown

exec sudo -u redis /usr/bin/redis-server /etc/redis/redis.conf

respawn
EOL

# Create the inspeqtor config file
cat >/etc/inspeqtor/services.d/redis-server.inq <<EOL
check service redis-server
EOL

chown redis:root /etc/init/redis-server.conf
initctl reload-configuration

if pgrep "redis-server" > /dev/null; then
  echo "Redis running, restarting."
  restart redis-server
else
  echo "Starting redis."
  start redis-server
fi
