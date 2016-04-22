if aptitude search '~i ^s3cmd$' | grep -q s3cmd; then
  echo "s3cmd already installed, skipping."
else
  apt-get -y install s3cmd

  mv ../files/.s3cmd /root/.s3cmd
fi
