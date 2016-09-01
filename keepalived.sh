# Set up keepalived.
#
# Required Files:
#
# - keepalived.conf

if aptitude search '~i ^keepalived$' | grep -q keepalived; then
  echo "keepalived already installed, skipping."
else
  apt-get -y install keepalived
fi

mkdir -p /etc/keepalived/hosts
mv files/keepalived.conf /etc/keepalived/keepalived.conf
