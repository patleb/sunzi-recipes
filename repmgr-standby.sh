# Setup a postgres node as a standby with repmgr.
#
# Required Files:
#
# - repmgr-standby.conf
# - repmgr/upstart.conf
# - repmgr/promote.sh
#
# Required Attributes:
#
# - pg_master_node [String] private ip address of the master postgres node

installed = false
if aptitude search '~i ^repmgr$' | grep -q repmgr; then
  echo "repmgr already installed, skipping."
else
  installed = true
  echo "installing repmgr"
  apt-get -y install repmgr
fi

mv files/repmgr-standby.conf /etc/repmgr.conf
mv files/repmgr/upstart.conf /etc/init/repmgr.conf

if [ -d /etc/repmgr ]; then
  echo "/etc/repmgr already exists"
else
  mkdir /etc/repmgr
  chown postgres:postgres /etc/repmgr
fi

mv files/repmgr/promote.sh /etc/repmgr/promote
chown postgres:postgres /etc/repmgr/promote
chmod +x /etc/repmgr/promote

if pgrep "repmgr" > /dev/null; then
  echo "Repmgr running, restarting."
  restart repmgr
else
  echo "Starting repmgr."
  start repmgr
fi

if $installed
  service postgresql stop
  rm -r /var/lib/postgresql/9.5/main/*
  su - postgres -c 'repmgr -h <%= @attributes.pg_master_node %> -U postgres -d repmgr -D /var/lib/postgresql/9.5/main -f /etc/repmgr.conf standby clone'
  service postgresql start
  su - postgres -c 'repmgr standby register'
fi
