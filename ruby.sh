ruby_version=$(cat attributes/ruby_version)

if [[ "$(rbenv version)" =~ $ruby_version* ]]; then
  echo "ruby-$ruby_version already installed, skipping"
else
  echo "Installing ruby-$ruby_version"
  rbenv install $ruby_version
  rbenv global $ruby_version

  echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
fi
