# Creates app directories, users, and nginx config.
#
# Required Files
#
# - env/{app-name}
# - nginx/{app-name}.conf
#
# Required Attributes
#
# - apps [Array<Hash>]

<% (@attributes.apps || []).each do |app| %>
  name=<%= app['name'] %>
  user="app-$name"

  if grep $user /etc/passwd; then
    echo "user $user already exists; skipping create"
  else
    adduser --disabled-password --gecos "" $user
  fi

  # make the home directory
  mkdir -p ~$user/.ssh

  # create the app directory
  mkdir -p /var/www/$name
  chown $user: /var/www/$name

  # create the shared directory
  mkdir -p /var/www/$name/shared
  mkdir -p /var/www/$name/shared/log
  mkdir -p /var/www/$name/shared/tmp/pids
  mkdir -p /var/www/$name/shared/sources
  mv files/env/$name /var/www/$name/shared/.env
  chown -R $user: /var/www/$name/shared

  # configure nginx
  mv files/nginx/$name.conf /etc/nginx/sites-enabled/$name.conf
  chown root /etc/nginx/sites-enabled/$name.conf
  chgrp root /etc/nginx/sites-enabled/$name.conf
<% end %>

service nginx restart
