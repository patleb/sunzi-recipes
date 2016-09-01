# Configures the hosts file.
#
# Required Attributes:
#
# - hosts [Array<Hash>] list of hostnames

<% if !@attributes.hosts %>
echo "DEPRECATED: hosts requires a host key with a list of hostnames"
<% else %>
# Setup hosts
cat>/etc/hosts <<EOT
127.0.0.1 localhost.local localhost
<%= @attributes.hosts.each do |hostname, info| %>
<%= info['ip'] %> <%= info['domain'] %> <%= hostname %>
<%= end %>

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOT
<% end %>
