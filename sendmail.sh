if aptitude search '~i ^sendmail$' | grep -q sendmail; then
  echo "sendmail already installed, skipping."
else
  apt-get -y install sendmail
fi
