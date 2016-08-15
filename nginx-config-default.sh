rm /etc/nginx/sites-enabled/default
mv files/nginx-default.conf /etc/nginx/sites-enabled/default
chown root /etc/nginx/sites-enabled/default
chgrp root /etc/nginx/sites-enabled/default
restart nginx
