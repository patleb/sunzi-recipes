rm /etc/nginx/nginx.conf
mv files/nginx.conf /etc/nginx/nginx.conf
chown root /etc/nginx/nginx.conf
chgrp root /etc/nginx/nginx.conf
service nginx restart
