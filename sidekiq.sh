if gem list | grep -q sidekiq; then
  echo 'sidekiq already installed, skipping.'
else  
  gem install sidekiq --no-rdoc --no-ri
fi
