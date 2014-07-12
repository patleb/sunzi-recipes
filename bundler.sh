if gem list | grep -q bundler; then
  echo 'bundler already installed, skipping.'
else
  gem install bundler
  rbenv rehash
fi
