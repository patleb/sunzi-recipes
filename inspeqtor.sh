if [ -e /etc/inspeqtor/inspeqtor.conf ]; then
  echo "Inspeqtor already installed, skipping."
else
  echo "Installing inspeqtor."
  curl -L https://bit.ly/InspeqtorDEB | bash # add inspeqtor repo
  apt-get install inspeqtor
fi

if pgrep "inspeqtor" > /dev/null; then
  echo "Restarting inspeqtor."
  initctl restart inspeqtor
else
  echo "Starting inspeqtor."
  initctl start inspeqtor
fi
