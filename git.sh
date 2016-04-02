if aptitude search '~i ^git$' | grep -q git; then
  echo "git already installed, skipping."
else
  sudo apt-get install -y git
fi

