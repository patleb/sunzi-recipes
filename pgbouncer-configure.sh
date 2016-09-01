# Configures pgbouncer to support a new node in the cluster. Typically run when
# provisioning a new master node, as this tells pgbouncer where to connect for
# particular databases, as well as what users are allowed to connect.
#
# Note that the public key for the postgres user on the master should be installed
# on the pgbouncer instance so that files can be uploaded properly.
#
# Required Files:
#
# - pgbouncer.ini
# - pgbouncer/userlist.txt
#
# Required Attributes:
#
# - pgbouncer_host [String] ip address of the pgbouncer instance
# - cluster_name [String] the name of the current cluster

# FIXME: support removing existing users from userlist.txt

# Configure pgbouncer with connection info
echo "Uploading pgbouncer.ini"
sudo -u postgres scp files/pgbouncer.ini postgres@<%= @attributes.pgbouncer_host %>:/etc/pgbouncer/config/<%= @attributes.cluster_name %>.ini
echo "Chowning pgbouncer.ini"
sudo -u postgres ssh postgres@<%= @attributes.pgbouncer_host %> 'chown postgres:postgres /etc/pgbouncer/config/<%= @attributes.cluster_name %>.ini'

# Configure pgbouncer with user info
echo "Uploading pgbouncer userlist.txt"
sudo -u postgres scp files/pgbouncer/userlist.txt postgres@<%= @attributes.pgbouncer_host %>:/etc/pgbouncer/config/userlist-<%= @attributes.cluster_name %>.txt
echo "Concatenating pgbouncer userlist.txt"
sudo -u postgres ssh postgres@<%= @attributes.pgbouncer_host %> 'cat ""/etc/pgbouncer/config/userlist-<%= @attributes.cluster_name %>.txt"" >> "/etc/pgbouncer/userlist.txt"'
echo "Removing uploaded pgbouncer userlist.txt"
sudo -u postgres ssh postgres@<%= @attributes.pgbouncer_host %> 'rm /etc/pgbouncer/config/userlist-<%= @attributes.cluster_name %>.txt'

# Reload pgbouncer
echo "Reloading pgbouncer"
sudo -u postgres ssh postgres@<%= @attributes.pgbouncer_host %> 'service pgbouncer reload'
