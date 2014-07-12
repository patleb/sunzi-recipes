if aptitude search '~i ^wkhtmltopdf$' | grep -q wkhtmltopdf; then
  echo "wkhtmltopdf already installed, skipping."
else
  apt-get -y install wkhtmltopdf
fi
