app_name=$(cat attributes/app_name)
app_path=$(cat attributes/app_path)
app_server=$(cat attributes/app_server)

# Create app directory
if [ -d $app_path ]; then
  echo "app already exists"
else
  echo "creating app structure"
  mkdir -p $app_path
  mkdir $app_path/shared
  mkdir $app_path/shared/log
  mkdir $app_path/shared/system
  mkdir $app_path/shared/tmp
fi

# Write env
mv files/env $app_path/shared/.env

# Rewrite nginx app config file
app_available=/etc/nginx/sites-available/$app_name

if [ -f $app_available ]; then
  rm $app_available
fi

# Write nginx conf
mv files/app-nginx.conf $app_available

# Symlink to make app available
app_enabled=/etc/nginx/sites-enabled/$app_name
if [ ! -f $app_enabled ]; then
  ln -s $app_available $app_enabled
fi

# Test nginx config
/etc/init.d/nginx configtest
if [ $? -eq 0 ]; then
  echo "nginx config test passed; restarting"
  /etc/init.d/nginx restart
else
  echo "nginx config test failed; fix it"
fi

# Setup thin
if [ "$app_server" == "thin" ]; then
  thin_conf=/etc/thin/$app_name.yml
  
  if [ -f $thin_conf ]; then
    rm $thin_conf
  fi

  mv files/app-thin.yml $thin_conf
fi

# Setup thin to use upstart
if [ "$app_server" == "thin" ]; then
  upstart_conf=/etc/init/$app_name.conf

  if [ -f $upstart_conf ]; then
    rm $upstart_conf
  fi

  mv files/upstart/$app_name.conf $upstart_conf

  service restart $app_name
fi
