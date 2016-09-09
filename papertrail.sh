# Installs papertrail.
#
# Required Files
#
# - papertrail.yml (based on https://github.com/papertrail/remote_syslog2/blob/master/examples/log_files.yml.example)
# - upstart/remote_syslog.conf

if [ -e /usr/local/bin/remote_syslog ]
then
  echo "remote_syslog already installed; skipping"
else
  wget https://github.com/papertrail/remote_syslog2/releases/download/v0.18/remote_syslog_linux_amd64.tar.gz
  tar xzf ./remote_syslog*.tar.gz
  cd remote_syslog
  sudo cp ./remote_syslog /usr/local/bin
  cd ../
  rm -rf ./remote_syslog
fi

mv files/papertrail.yml /etc/log_files.yml
chown root /etc/log_files.yml
chgrp root /etc/log_files.yml

mv files/upstart/remote_syslog.conf /etc/init/remote_syslog.conf
chown root /etc/init/remote_syslog.conf
chgrp root /etc/init/remote_syslog.conf

if status remote_syslog | grep -q 'remote_syslog start/running'; then
  restart remote_syslog
else
  start remote_syslog
fi
