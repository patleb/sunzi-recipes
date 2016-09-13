# Configures a web node to act as a standby for another web node. This works by rsyncing
# the necessary items from the primary node to the standby. Requires passwordless auth to
# be configured between the two nodes.
#
# Required Attributes
#
# - primary_node [String] the public ip address of the node this standby is acting for
# - public_ip [String] the public ip of the standby node

<%
  rsync_dirs = {
    "/usr/local/rbenv/*" => "/usr/local/rbenv",
    "/var/www/*" => "/var/www",
    "/etc/nginx/sites-enabled/*" => "/etc/nginx/sites-enabled",
    "/etc/log_files.yml" => nil,
    "/etc/init/sidekiq.conf" => nil,
    "/etc/init/workers.conf" => nil,
    "/etc/profile.d/rbenv.sh" => nil,
    "/root/.gemrc" => nil,
  }

  rsync_dirs.each_pair do |src, dst|
%>

ssh root@<%= @attributes.primary_node %> 'rsync -a --exclude=*.log* <%= src %> root@<%= @attributes.public_ip %>:<%= dst %>'

<% end %>

# restart nginx
service nginx restart

# restart remote syslog
if status remote_syslog | grep -q 'remote_syslog start/running'; then
  restart remote_syslog
else
  start remote_syslog
fi
