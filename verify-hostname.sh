if [ -e /etc/hostname-should-verify ]
then
  grep "^<%= @attributes.hostname %>$" /etc/hostname || exit 1
else
  echo 'hostname has not been set by us; allowing access this once'
  touch /etc/hostname-should-verify
fi
