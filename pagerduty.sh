if aptitude search '~i ^pdagent$' | grep -q pdagent; then
  echo "pdagent already installed, skipping."
else  
  wget -O - https://packages.pagerduty.com/GPG-KEY-pagerduty | sudo apt-key add -
  sh -c 'echo "deb https://packages.pagerduty.com/pdagent deb/" >/etc/apt/sources.list.d/pdagent.list'
  apt-get update
  apt-get -y install pdagent pdagent-integrations
fi
