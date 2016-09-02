# Installs ruby versions via rbenv.
#
# Required Attributes
#
# rubies [Array<String>] a list of versions to install
# global_ruby [String] verion that should be global

# Makes rbenv command available
source ~/.bash_profile

<% if @attributes.ruby_version %>
echo "DEPRECATED: use rubies attribute rather than ruby_version"
<% end %>

<% (@attributes.rubies || []).each do |version| %>
if [[ "$(rbenv versions)" =~ <%= version %> ]]; then
  echo "ruby-<%= version %> already installed, skipping"
else
  echo "Installing ruby-<%= version %>"
  rbenv install <%= version %>
fi

rbenv shell <%= version %>
if gem list | grep -q bundler; then
  echo 'bundler already installed for ruby-<%= version %>, skipping.'
else
  gem install bundler
  rbenv rehash
fi
<% end %>

rbenv global <%= @attributes.global_ruby %>
