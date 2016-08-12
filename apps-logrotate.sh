# Upload logrotate configuration

# It's safe to just add and not check it if exists because we would
# want to override this if it is already there.

cat >/etc/logrotate.d/apps-logrotate <<EOL
/var/www/*/shared/log/*log
  rotate 3
  daily
  compress
  delaycompress
  sharedscripts
  postrotate
    /usr/bin/passenger-config restart-app / > /dev/null
  endscript
}
EOL

chown root:root /etc/logrotate.d/apps-logrotate
