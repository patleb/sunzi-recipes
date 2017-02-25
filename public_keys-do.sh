<% @attributes.public_keys.each do |user, keys| %>
  <% user_ssh_dir = File.join(@attributes.user_dirs[user], ".ssh") %>
  <% authorized_keys = File.join(user_ssh_dir, "authorized_keys") %>

  echo "Creating ssh directory for <%= user %>"
  mkdir -p <%= user_ssh_dir %>
 
  <% keys["local_keys"].each do |server_name| %>
    echo "Installing public key for <%= server_name %>.<%= user %>"
    <% key = (`cat ../../servers/#{server_name}/files/keys/#{user}/id_rsa.pub`).strip %>
    touch <%= authorized_keys %>
    grep -q -F "<%= key %>" <%= authorized_keys %> || echo "<%= key %>" >> <%= authorized_keys %>
  <% end %>

  echo "Setting key permissions for <%= user %>"
  chown -R <%= user %> <%= user_ssh_dir %>
<% end %>
