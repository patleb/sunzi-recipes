# Upload logrotate configuration

# It's safe to just add and not check it if exists because we would
# want to override this if it is already there.
hostname=$(cat attributes/hostname)
cat >/etc/logrotate.d/rsyslog <<EOL
/var/log/syslog
{
        rotate 4
        weekly
        missingok
        notifempty
        delaycompress
        compress
        postrotate
                reload rsyslog >/dev/null 2>&1 || true
                /usr/bin/s3cmd -m text/plain sync /var/log/syslog.2.gz s3://platform-server-logs/${hostname}/syslog.$(date +"%Y%m%d").gz
        endscript
}

EOL

chown root:root /etc/logrotate.d/rsyslog
