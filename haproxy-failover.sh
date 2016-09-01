# Setup haproxy failover with keepalived.
#
# Required Files:
#
# - keepalived/haproxy.conf
#
# Required Recipes:
#
# - keepalived

mv files/keepalived/haproxy.conf /etc/keepalived/hosts/haproxy.conf

if pgrep "keepalived" > /dev/null; then
  echo "restarting keepalived"
  service keepalived restart
else
  echo "starting keepalived"
  service keepalived start
fi
