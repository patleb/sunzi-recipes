# Setup networking
cat >/etc/network/interfaces <<'EOT'
auto lo
iface lo inet loopback

auto eth0 eth0:0

iface eth0 inet static
 address <%= @attributes.public_ip %>
 netmask <%= @attributes.public_netmask || '255.255.255.0' %>
 gateway <%= @attributes.public_gateway %>

iface eth0:0 inet static
 address <%= @attributes.private_ip %>
 netmask <%= @attributes.private_netmask || '255.255.128.0' %>
EOT

/etc/init.d/networking restart
