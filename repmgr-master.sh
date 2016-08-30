# Setup a postgres node as a master with repmgr.
#
# Required Files:
#
# - repmgr-master.conf

if aptitude search '~i ^repmgr$' | grep -q repmgr; then
  echo "repmgr already installed, skipping."
else
  echo "installing repmgr"
  apt-get -y install repmgr
fi

mv files/repmgr-master.conf /etc/repmgr.conf

# Create the repmgr database unless it exists
su - postgres -c 'psql -lqt | cut -d \| -f 1 | grep -q "repmgr"' ||
  sudo -u postgres createdb repmgr --owner=postgres

# Register this node as a master
su - postgres -c 'repmgr master register'
