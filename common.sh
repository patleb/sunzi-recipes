# Install aptitude
apt-get -y install aptitude

# Install make
source recipes/make.sh

# Setup utlities
source recipes/utilities.sh

# Install/Setup ntp
source recipes/ntp.sh

# Install/Setup fail2ban
source recipes/fail2ban.sh
