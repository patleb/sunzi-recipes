public_ip=$(cat attributes/public_ip)
public_gateway=$(cat attributes/public_gateway)
private_ip=$(cat attributes/private_ip)

# Setup networking
cat >/etc/network/interfaces <<EOT
auto lo
iface lo inet loopback

auto eth0 eth0:0

iface eth0 inet static
 address ${public_ip}
 netmask '255.255.255.0'
 gateway ${public_gateway}

iface eth0:0 inet static
 address ${private_ip}
 netmask 255.255.128.0
EOT

/etc/init.d/networking restart
