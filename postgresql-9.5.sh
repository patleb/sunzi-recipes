if aptitude search '~i ^postgresql-9.5$' | grep -q postgresql-9.5; then
  echo "postgresql-9.5 already installed, skipping."
else
  echo "installing postgres"
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
  apt-get update

  apt-get -y install postgresql-9.5 postgresql-server-dev-9.5 postgresql-contrib-9.5
fi

if cmp -s files/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf; then
  echo "postgresql.conf file is identical, skipping copy"
else
  # Install configuration
  rm /etc/postgresql/9.5/main/postgresql.conf
  mv files/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
  chown postgres /etc/postgresql/9.5/main/postgresql.conf
fi

if cmp -s files/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf; then
  echo "pg_hba.conf file is identical, skipping copy"
else
  # Enable client authentication
  rm /etc/postgresql/9.5/main/pg_hba.conf
  mv files/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
  chown postgres /etc/postgresql/9.5/main/pg_hba.conf
fi
# disable initd and add upstart supervisor config
update-rc.d postgresql disable
mv files/pg_versions_upstart.conf /etc/init/pg_versions.conf
mv files/pg_cluster_upstart.conf /etc/init/pg_cluster.conf
mv files/pg_agent_upstart.conf /etc/init/pg_agent.conf
#inspeqtor config
mv files/pg_inspeqtor.inq /etc/inspeqtor/services.d/postgres.inq
initctl reload-configuration

if pgrep "postgres" > /dev/null; then
  echo "Restarting postgres."
  restart pg_versions
else
  echo "Starting postgres."
  start pg_versions
fi
