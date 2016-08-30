# Installs Postgres 9.5
#
# Required Files:
#
# - postgres.conf
# - postgres/pg_hba.conf

restart=false
if aptitude search '~i ^postgresql-9.5$' | grep -q postgresql-9.5; then
  echo "postgresql-9.5 already installed, skipping."
else
  echo "installing postgres"
  restart=true
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
  apt-get update

  apt-get -y install postgresql-9.5 postgresql-server-dev-9.5 postgresql-contrib-9.5
fi

if cmp -s files/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf; then
  echo "postgresql.conf file is identical, skipping copy"
else
  echo "postgresql.conf file is modified, replacing."
  restart=true

  # Install configuration
  rm /etc/postgresql/9.5/main/postgresql.conf
  mv files/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
  chown postgres /etc/postgresql/9.5/main/postgresql.conf
fi

if cmp -s files/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf; then
  echo "pg_hba.conf file is identical, skipping copy"
else
  echo "pg_hba.conf file is modified, replacing."
  restart=true

  # Enable client authentication
  rm /etc/postgresql/9.5/main/pg_hba.conf
  mv files/postgres/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
  chown postgres /etc/postgresql/9.5/main/pg_hba.conf
fi

if [ $restart = true ]; then
  /etc/init.d/postgresql restart
else
  echo "No update, skipping postgres restart"
fi
