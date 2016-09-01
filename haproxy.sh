if aptitude search '~i ^haproxy$' | grep -q haproxy; then
  echo "haproxy already installed, skipping."
else
  add-apt-repository ppa:vbernat/haproxy-1.6
  apt-get update
  apt-get -y install haproxy
fi
