if aptitude search '~i ^imagemagick$' | grep -q imagemagick; then
  echo "imagemagick already installed, skipping."
else
  apt-get -y install imagemagick libmagickcore-dev libmagickwand-dev
fi
