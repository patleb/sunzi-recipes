if aptitude search '~i ^pdftk$' | grep -q pdftk; then
  echo "pdftk already installed, skipping."
else
  apt-get -y install pdftk
fi
