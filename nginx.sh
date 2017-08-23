if aptitude search '~i ^nginx$' | grep -q nginx; then
  echo "nginx already installed, skipping."
else
  apt-get -y install nginx
  
  mv files/nginx.conf /etc/nginx/nginx.conf

  service nginx start
fi
