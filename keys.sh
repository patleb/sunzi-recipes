<% @attributes.keys.each do |key| %>
grep -q -F '<%= key %>' /root/.ssh/authorized_keys || echo '<%= key %>' >> /root/.ssh/authorized_keys
<% end %>
