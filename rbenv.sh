if [ -d ~/.rbenv ]; then
  echo "rbenv already installed, skipping"
else
  apt-get install -y build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev
 
  # install rbenv
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

  # install ruby-build
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

  # Makes rbenv command available
  source ~/.bash_profile
fi
