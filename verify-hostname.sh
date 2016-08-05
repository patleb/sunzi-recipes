hostname=$(cat attributes/hostname)

if [ -e /etc/hostname-should-verify ]
then
  echo "hostname set; comparing value $hostname to node"
  grep "^$hostname$" /etc/hostname || exit 1
else
  echo 'hostname has not been set by us; allowing access this once'
  touch /etc/hostname-should-verify
fi
