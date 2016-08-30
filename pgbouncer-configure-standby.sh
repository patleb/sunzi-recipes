# Configures pgbouncer.ini on a standby machine. Used when failing over.
#
# Required Files:
#
# - pgbouncer.ini

echo "Moving pgbouncer into place"
mv files/pgbouncer.ini /etc/repmgr/pgbouncer.ini
chown postgres:postgres /etc/repmgr/pgbouncer.ini
