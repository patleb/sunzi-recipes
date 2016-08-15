#install inspeqtor conf
mv files/nginx_inspeqtor.inq /etc/inspeqtor/services.d/nginx.inq
initctl reload-configuration
#install upstart conf
mv files/nginx_upstart.conf /etc/init/nginx.conf
update-rc.d nginx disable

rm -f /etc/nginx/nginx.conf
rm -f /etc/logrotate.d/nginx

mv files/nginx.conf /etc/nginx/nginx.conf
mv files/nginx-logrotate.conf /etc/logrotate.d/nginx

chown root /etc/nginx/nginx.conf
chgrp root /etc/nginx/nginx.conf

restart nginx
