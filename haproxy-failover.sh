# Setup haproxy failover with keepalived.
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
mv files/keepalived/haproxy-master.conf /etc/keepalived/hosts/haproxy.conf
<% else %>
mv files/keepalived/haproxy-standby.conf /etc/keepalived/hosts/haproxy.conf
<% end %>

if pgrep "keepalived" > /dev/null; then
  echo "restarting keepalived"
  service keepalived restart
else
  echo "starting keepalived"
  service keepalived start
fi
