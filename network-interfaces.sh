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
 address <%= @attributes.public_ip %>
 netmask '255.255.255.0'
 gateway <%= @attributes.public_gateway %>

<% if @attributes.private_ip %>
iface eth0:0 inet static
 address <%= @attributes.private_ip %>
 netmask 255.255.128.0
<% end %>

<% if @attributes.failover_ip && @attributes.failover_gateway %>
auto eth0:1
iface eth0:1 inet static
  address <%= @attributes.failover_ip %>
  gateway <%= @attributes.failover_gateway %>
  netmask 255.255.255.0
<% end %>
EOT
