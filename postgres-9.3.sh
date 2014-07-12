if aptitude search '~i ^postgresql-9.3$' | grep -q postgresql-9.3; then
  echo "postgresql-9.3 already installed, skipping."
else
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
  apt-get update

  apt-get -y install postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3
fi
