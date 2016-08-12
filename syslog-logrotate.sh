# Upload logrotate configuration

# It's safe to just add and not check it if exists because we would
# want to override this if it is already there.
hostname=$(cat attributes/hostname)
cat >/etc/logrotate.d/rsyslog <<EOL
//var/log/syslog
{
        rotate 4
        weekly
        missingok
        notifempty
        delaycompress
        compress
        postrotate
                reload rsyslog >/dev/null 2>&1 || true

                /usr/bin/s3cmd -m text/plain sync /var/log/syslog.0.gz s3://platform-server-logs/${hostname}/syslog.$(date +"%Y%m%d").gz
        endscript
}

/var/log/mail.info
/var/log/mail.warn
/var/log/mail.err
/var/log/mail.log
/var/log/daemon.log
/var/log/kern.log
/var/log/auth.log
/var/log/user.log
/var/log/lpr.log
/var/log/cron.log
{
        rotate 4
        weekly
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                reload rsyslog >/dev/null 2>&1 || true

                /usr/bin/s3cmd -m text/plain sync /var/log/cron.0.gz s3://platform-server-logs/${hostname}/cron.$(date +"%Y%m%d").gz
        endscript
}
/var/log/debug
/var/log/messages
{
        rotate 4
        weekly
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                reload rsyslog >/dev/null 2>&1 || true

                /usr/bin/s3cmd -m text/plain sync /var/log/messages.0.gz s3://platform-server-logs/${hostname}/messages.$(date +"%Y%m%d").gz
        endscript
}
EOL

chown root:root /etc/logrotate.d/rsyslog
