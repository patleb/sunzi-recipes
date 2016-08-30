# Installs Sensu checks for Postgres
#
# Required Files:
#
# - sensu/postgres.json

conf_dst=/etc/sensu/conf.d/postgres.json
conf_src=files/sensu/postgres.json

if /usr/local/rbenv/shims/gem list | grep -q backup; then
  echo "Postgres monitoring plugin installed, skipping..."
else
  /usr/local/rbenv/shims/gem install sensu-plugins-postgres -v 0.1.1
fi

echo "Copying the postgres monitoring config"
rm -f $conf_dst
cp $conf_src $conf_dst

service sensu-client restart

