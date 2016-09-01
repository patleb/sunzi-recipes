if aptitude search '~i ^pdagent$' | grep -q pdagent; then
  echo "pdagent already installed, skipping."
else
  wget -O - http://packages.pagerduty.com/GPG-KEY-pagerduty | sudo apt-key add -
  apt-get update
  apt-get -y install pdagent pdagent-integrations
fi
