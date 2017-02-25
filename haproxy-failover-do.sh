# Setup haproxy failover with keepalived on DO.
#
# Required Files:
#
# - keepalived/haproxy.conf
#
# Required Recipes:
#
# - keepalived
#
# Required Attributes:
#
# - is_haproxy_master [Boolean] whether this node is the master

<% if @attributes.is_haproxy_master %>
mv files/keepalived/haproxy-master-do.conf /etc/keepalived/hosts/haproxy.conf
<% else %>
mv files/keepalived/haproxy-standby-do.conf /etc/keepalived/hosts/haproxy.conf
<% end %>

if pgrep "keepalived" > /dev/null; then
  echo "restarting keepalived"
  service keepalived restart
else
  echo "starting keepalived"
  service keepalived start
fi

# Install pip, so we can install helper dependencies
if aptitude search '~i ^python-pip$' | grep -q python-pip; then
  echo "python-pip already installed, skipping."
else
  apt-get -y install python-pip
  pip install --upgrade pip
fi

# Install requests (dependency of helper)
pip install requests

# Download the failover ip helper
cd /usr/local/bin && curl -LOs http://do.co/assign-ip && cd -

# Create the master failover script
mv files/keepalived/master.sh /etc/keepalived/master.sh
chmod +x /etc/keepalived/master.sh
