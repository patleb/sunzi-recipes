if aptitude search '~i ^fail2ban$' | grep -q fail2ban; then
  echo "fail2ban already installed, skipping."
else
  apt-get -y install fail2ban
fi

cat >/etc/fail2ban/fail2ban.local <<EOL
[Definition]

loglevel = WARNING
logtarget = /var/log/fail2ban.log
et = /var/run/fail2ban/fail2ban.sock
pidfile = /var/run/fail2ban/fail2ban.pid
EOL

cat >/etc/fail2ban/jail.local <<EOL
# Edit default settings to jails here.
EOL

fail2ban-client reload
