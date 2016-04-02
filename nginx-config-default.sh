rm /etc/nginx/sites-enabled/default
mv files/nginx-default.conf /etc/nginx/sites-enabled/default
service nginx restart
