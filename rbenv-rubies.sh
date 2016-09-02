# Installs ruby versions via rbenv.
#
# Required Attributes
#
# rubies [Array<String>] a list of versions to install

# Makes rbenv command available
source ~/.bash_profile

<% if @attributes.ruby_version %>
echo "DEPRECATED: use rubies attribute rather than ruby_version"
<% end %>

<% (@attributes.rubies || []).each do |version| %>
if [[ "$(rbenv version)" =~ <%= version %>* ]]; then
  echo "ruby-<%= version %> already installed, skipping"
else
  echo "Installing ruby-<%= version %>"
  rbenv install <%= version %>
fi
<% end %>
