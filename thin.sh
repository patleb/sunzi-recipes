if gem list | grep -q thin; then
  echo 'thin already installed, skipping.'
else  
  gem install thin

  # Setup thin to start on reboot
  thin install
  /usr/sbin/update-rc.d -f thin defaults
fi
