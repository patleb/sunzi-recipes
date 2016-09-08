# Installs and configures sidekiq.
#
# Required Files
#
# - sidekiq.conf
# - sidekiq/workers.conf

if gem list | grep -q sidekiq; then
  echo 'sidekiq already installed, skipping.'
else
  gem install sidekiq --no-rdoc --no-ri
fi

if cmp -s files/sidekiq.conf /etc/init/sidekiq.conf; then
  echo "Sidekiq configuration is identical, skipping copy"
else
  echo "Sidekiq configuration is modified, replacing."
  mv files/sidekiq.conf /etc/init/sidekiq.conf
  chown root /etc/init/sidekiq.conf
  chgrp root /etc/init/sidekiq.conf
fi

if cmp -s files/workers.conf /etc/init/workers.conf; then
  echo "Sidekiq worker configuration is identical, skipping copy"
else
  echo "Sidekiq worker configuration is modified, replacing."
  mv files/sidekiq/workers.conf /etc/init/workers.conf
  chown root /etc/init/workers.conf
  chgrp root /etc/init/workers.conf

  if status workers | grep -q 'workers start/running'; then
    restart workers
  else
    start workers
  fi
fi
