if aptitude search '~i ^redis-server$' | grep -q redis-server; then
  echo "redis-server already installed, skipping."
else
  apt-add-repository ppa:chris-lea/redis-server
  apt-get update
  
  apt-get -y install redis-server
fi
