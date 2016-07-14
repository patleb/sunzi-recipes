if [ ! -d "/usr/local/etc/couchdb" ]; then
  sudo apt-get update
  sudo apt-get -y install build-essential erlang-base-hipe erlang-dev erlang-manpages erlang-eunit erlang-nox libicu-dev libmozjs185-dev libcurl4-openssl-dev
  wget http://mirrors.advancedhosters.com/apache/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz
  tar -zxvf apache-couchdb-*.tar.gz
  cd apache*
  ./configure
  make && sudo make install
  sudo adduser --disabled-login --disabled-password --no-create-home --gecos "" couchdb || true
  sudo chown -R couchdb:couchdb /usr/local/var/lib/couchdb
  sudo chown -R couchdb:couchdb /usr/local/var/log/couchdb
  sudo chown -R couchdb:couchdb /usr/local/var/run/couchdb
  sudo chown -R couchdb:couchdb /usr/local/etc/couchdb
  sudo chmod 0770 /usr/local/var/lib/couchdb/
  sudo chmod 0770 /usr/local/var/log/couchdb/
  sudo chmod 0770 /usr/local/var/run/couchdb/
  sudo chmod 0770 /usr/local/etc/couchdb/*.ini
  sudo chmod 0770 /usr/local/etc/couchdb/*.d
  sudo ln -s /usr/local/etc/logrotate.d/couchdb /etc/logrotate.d/couchdb
  sudo ln -s /usr/local/etc/init.d/couchdb /etc/init.d
  sudo update-rc.d couchdb defaults

  couchdb -b
else
  echo "couchdb already installed, skipping."
fi

