# Configures MySQL replication on a node.
#
# Required Attributes:
#
# - mysql_replication_password [String] must be < 32 characters!

mysql -u root -e 'select count(*) from mysql.user where User = "replicator"' | grep -q 1 ||
  mysql -u root -e "create user 'replicator'@'%' identified by '<%= @attributes.mysql_replication_password %>'"
mysql -u root -e "grant replication slave on *.* to 'replicator'@'%'; flush privileges"

mysql -u root -e 'select count(*) from mysql.user where User = "replicator"' | grep -q 1 ||
  mysql -u root -e "create user 'haproxy_check'@'%' identified by ''"

echo "Use the following info in the replication command to follow:"
mysql -u root -e "show master status"
echo "Run the following commands to start replication on a standby:"
echo "slave stop;"
echo "CHANGE MASTER TO MASTER_HOST = '{master_node_ip}', MASTER_USER = 'replicator', MASTER_PASSWORD = '<%= @attributes.mysql_replication_password %>', MASTER_LOG_FILE = '{info.File}', MASTER_LOG_POS = {info.Position};"
echo "slave start;"
