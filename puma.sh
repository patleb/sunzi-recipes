app_path=$(cat attributes/app_path)
socket_path=$app_path/shared/sockets
pids_path=$app_path/shared/pids

if [ ! -d $socket_path ]; then
  mkdir $socket_path
fi

if [ ! -d $pids_path ]; then
  mkdir $pids_path
fi

cp files/puma.conf files/puma-manager.conf /etc/init

puma_conf=/etc/puma.conf
if [ ! -f $puma_conf ]; then
  touch $puma_conf
fi

current_path=$app_path/current
if ! grep "$current_path" $puma_conf; then
  echo "$current_path" >> $puma_conf
fi

start puma-manager
