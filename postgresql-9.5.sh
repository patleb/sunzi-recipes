if aptitude search '~i ^postgresql-9.5$' | grep -q postgresql-9.5; then
  echo "postgresql-9.5 already installed, skipping."
else
  echo "installing postgres"
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
  apt-get update

  apt-get -y install postgresql-9.5 postgresql-server-dev-9.5 postgresql-contrib-9.5
fi

# Install configuration
rm /etc/postgresql/9.5/main/postgresql.conf
mv files/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
chown postgres /etc/postgresql/9.5/main/postgresql.conf

# Enable client authentication
rm /etc/postgresql/9.5/main/pg_hba.conf
mv files/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
chown postgres /etc/postgresql/9.5/main/pg_hba.conf

/etc/init.d/postgresql restart

