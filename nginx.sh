if aptitude search '~i ^nginx$' | grep -q nginx; then
  echo "nginx already installed, skipping."
else
  apt-get -y install nginx

  # increase max size of server name
  sed -i "/server_names_hash_bucket_size/ s/# *//" /etc/nginx/nginx.conf
fi

if pgrep "nginx" > /dev/null; then
  echo "Nginx running, restarting."
  restart nginx
else
  echo "Starting nginx."
  start nginx
fi
