# Creates app users for a failover node.
#
# Required Attributes
#
# - apps [Array<Hash>]

<% @attributes.apps.each do |app| %>
  name=<%= app['name'] %>
  user="app-$name"

  if grep $user /etc/passwd; then
    echo "user $user already exists; skipping create"
  else
    adduser --disabled-password --gecos "" $user
  fi

  # make the home directory
  mkdir -p ~$user/.ssh
<% end %>
