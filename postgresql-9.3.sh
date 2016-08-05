private_ip=$(cat attributes/private_ip)

if aptitude search '~i ^postgresql-9.3$' | grep -q postgresql-9.3; then
  echo "postgresql-9.3 already installed, skipping."
else
  echo "installing postgres"
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
  apt-get update

  apt-get -y install postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3
fi

if [ ! -z "$private_ip" ]; then
  # bind on the private ip
  file='/etc/postgresql/9.3/main/postgresql.conf'
  grep -q "^listen_addresses =" $file && sed "s/^listen_addresses = .*/listen_addresses = '$private_ip'/" -i $file || 
    sed "$ a\listen_addresses = '$private_ip'" -i $file

  # allow access
  file='/etc/postgresql/9.3/main/pg_hba.conf'
  conf='host    all             all             all                     md5'
  if [ ! grep -q "^$conf" $file]; then
    sed "$ a\$conf" -i $file
  fi
fi

# Always Restart
service postgresql restart
