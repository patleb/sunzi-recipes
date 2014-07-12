public_ip=$(cat attributes/public_ip)
public_domain=$(cat attributes/public_domain)
hostname=$(cat attributes/hostname)

# Setup hosts
cat>/etc/hosts <<EOT
127.0.0.1 localhost.localdomain localhost
${public_ip} ${public_domain} ${hostname}

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOT
