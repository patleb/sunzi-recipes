rm -f /etc/nginx/nginx.conf
rm -f /etc/logrotate.d/nginx

mv files/nginx.conf /etc/nginx/nginx.conf

hostname=$(cat attributes/hostname)
cat >/etc/logrotate.d/nginx <<EOL
/var/log/nginx/*.log
{
        weekly
        missingok
        rotate 4
        compress
        delaycompress
        notifempty
        create 0640 www-data adm
        sharedscripts
        prerotate
                if [ -d /etc/logrotate.d/httpd-prerotate ]; then \
                        run-parts /etc/logrotate.d/httpd-prerotate; \
                fi \
        endscript
        postrotate
                invoke-rc.d nginx rotate >/dev/null 2>&1 \

                /usr/bin/s3cmd -m text/plain sync /var/log/nginx/access.log.1.gz s3://platform-server-logs/${hostname}/nginx.access.log.$(date +"%Y%m%d").gz \
                /usr/bin/s3cmd -m text/plain sync /var/log/nginx/error.log.1.gz s3://platform-server-logs/${hostname}/nginx.error.log.$(date +"%Y%m%d").gz \
        endscript
}
EOL

chown root:root /etc/logrotate.d/nginx
chown root /etc/nginx/nginx.conf
chgrp root /etc/nginx/nginx.conf

service nginx restart
