# Installs and configures pgbouncer.
#
# DOES NOT configure the actual database connections or users. It's expected
# that each postgres install will configure this on its own.
#
# Required Files:
#
# - pgbouncer/pgbouncer.ini

# name of the package to install
package=pgbouncer
# name of the service to manage
service=pgbouncer

# user who should own config files, etc
owner_user=postgres
# group who should own config files, etc
owner_group=postgres

# where to find the core config file
config_src=files/pgbouncer.ini
# where to put the core config file
config_dst=/etc/pgbouncer/pgbouncer.ini
# where cluster config directory should live
config_dir=/etc/pgbouncer/config

if aptitude search "~i ^$package\$" | grep -q $package; then
  echo "$package already installed, skipping."
else
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'

  apt-get update
  apt-get install $package -y
  service $service start
fi

# Update pgbouncer config
mv $config_src $config_dst
chown $owner_user:$owner_group $config_dst

# Create the config directory that contains routing info for each cluster.
if [ -d $config_dir ]; then
  echo "$config_dir already exists"
else
  mkdir $config_dir
  chown $owner_user:$owner_group $config_dir
fi

service $service restart
