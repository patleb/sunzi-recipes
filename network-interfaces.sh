# Configures network interfaces.
#
# Required Attributes
#
# - public_ip
# - public_gateway
#
# Optional Attributes
#
# - private_ip [String] will configure a private ip
# - failover_ip [String] will configure a failover ip
# - failover_gateway [String]

cat >/etc/network/interfaces <<EOT
auto lo
iface lo inet loopback

auto eth0 eth0:0

iface eth0 inet static
 address <%= @attributes.public_ip %>/24
 gateway <%= @attributes.public_gateway %>

<% if @attributes.private_ip %>
iface eth0:0 inet static
 address <%= @attributes.private_ip %>/17
<% end %>

<% if @attributes.failover_ip && @attributes.failover_gateway %>
iface eth0:0 inet static
 address <%= @attributes.failover_ip %>/24
 gateway <%= @attributes.failover_gateway %>
<% end %>
EOT

echo "Reboot for network changes to take effect!"
