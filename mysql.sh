restart=false
if aptitude search '~i ^mysql-server$' | grep -q mysql-server; then
  echo "mysql already installed, skipping."
else
  restart=true
  apt-get -y install mysql-server
fi

if cmp -s files/my.cnf /etc/mysql/my.cnf; then
  echo "my.cnf file is identical, skipping copy"
else
  restart=true
  mv /etc/mysql/my.cnf /etc/mysql/my.cnf.back
  mv files/my.cnf /etc/mysql/my.cnf
fi

if [ $restart = true ]; then
  service mysql restart || true
else
  echo "No update, skipping mysql restart"
fi
