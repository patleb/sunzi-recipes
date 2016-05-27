-rm /etc/nginx/nginx.conf
-rm /etc/logrotate.d/nginx

mv files/nginx.conf /etc/nginx/nginx.conf
mv files/nginx-logrotate.conf /etc/logrotate.d/nginx

chown root /etc/nginx/nginx.conf
chgrp root /etc/nginx/nginx.conf

service nginx restart
