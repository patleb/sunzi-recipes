# Installs public keys for multiple users.
#
# Required Attributes:
#
# - public_keys [Array<Hash>] list of users, with user directory and keys
#     e.g.
#     public_keys:
#       {user}:
#         user_dir: {user_dir}
#         keys:
#           - {key}

if aptitude search '~i ^jq$' | grep -q jq; then
  echo "jq already installed, skipping."
else
  sudo apt-get install -y jq
fi

<% if @attributes.keys %>
echo "DEPRECATION: public_keys attribute should now be used in place of keys"
<% end %>

<% @attributes.public_keys.each do |user, info| %>
  if [ ! -d "<%= info['user_dir'] %>/.ssh" ]; then
    echo "Creating ssh directory for <%= user %>"
    mkdir <%= info['user_dir'] %>/.ssh
    touch <%= info['user_dir'] %>/.ssh/authorized_keys
    chown -r <%= user %> <%= info['user_dir'] %>/.ssh
  fi

  <% info['keys'].each do |key| %>
    echo "Uploading key for <%= user %>"
    grep -q -F "<%= key %>" <%= info['user_dir'] %>/.ssh/authorized_keys || echo <%= key %> >> <%= info['user_dir'] %>/.ssh/authorized_keys
  <% end %>
<% end %>
