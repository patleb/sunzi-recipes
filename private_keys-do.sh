<% @attributes.private_keys.each do |user| %>
  <% user_ssh_dir = File.join(@attributes.user_dirs[user], ".ssh") %>

  echo "Creating ssh directory for <%= user %>"
  mkdir -p <%= user_ssh_dir %>
  
  echo "Installing private key for <%= user %>"
  mv files/keys/<%= user %>/id_rsa <%= user_ssh_dir %>
  
  echo "Setting key permissions for <%= user %>"
  chown -R <%= user %> <%= user_ssh_dir %>
  chmod 400 <%= File.join(user_ssh_dir, "id_rsa") %>
<% end %>
