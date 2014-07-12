if aptitude search '~i ^mysql-server$' | grep -q mysql-server; then
  echo "mysql already installed, skipping."
else
  apt-get -y install mysql-server

  mv /etc/mysql/my.cnf /etc/mysql/my.cnf.back
  mv files/my.cnf /etc/mysql/my.cnf

  service mysql restart
fi
