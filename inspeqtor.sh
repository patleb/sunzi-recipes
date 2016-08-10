if [ -e /etc/inspeqtor/inspeqtor.conf ] then
  echo "Inspeqtor already installed, skipping."
else
  curl -L https://bit.ly/InspeqtorDEB | bash # add inspeqtor repo
  apt-get install inspeqtor
fi
