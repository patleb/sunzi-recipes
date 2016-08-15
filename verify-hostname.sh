hostname=$(cat attributes/hostname)
nodename=$(cat /etc/hostname)

if [ -e /etc/hostname-should-verify ]
then
  echo "hostname set; comparing value $hostname to $nodename"
  grep "^$hostname$" /etc/hostname || exit 1
else
  echo 'hostname has not been set by us; allowing access this once'
  touch /etc/hostname-should-verify
fi
