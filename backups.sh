if gem list | grep -q backup; then
  echo 'Backup already installed, skipping.'
else
  gem install backup --no-ri --no-rdoc
  rbenv rehash
fi

if gem list | grep -q whenever; then
  echo 'Whenever already installed, skipping.'
else
  gem install whenever --no-ri --no-rdoc
  rbenv rehash
fi

if [ -d /etc/backup ]; then
  echo " location already created"
else
  mkdir /etc/backup
  mkdir /etc/backup/models
fi

cat >/etc/backup/config.rb <<EOL
# encoding: utf-8
# Backup v4.x Configuration
root_path '/etc/backup'
tmp_path  'tmp'
data_path 'data'

Storage::S3.defaults do |s3|
  s3.access_key_id     = "AKIAIQFOTP6RDQUVJ7KA"
  s3.secret_access_key = "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"
  s3.bucket            = "platform-node-backups"
end

Storage::Dropbox.defaults do |db|
  db.api_key     = "ctl7gd9wd0xtc89"
  db.api_secret  = "6oqdfizjvb6ko7k"
  db.cache_path  = ".cache"
  db.access_type = :app_folder
end

Encryptor::OpenSSL.defaults do |encryption|
  encryption.password = 'BCCD&oftz=tHauet4KbuX6RFHp3%sR'
  encryption.base64   = true
  encryption.salt     = true
end

Notifier::Slack.defaults do |slack|
  slack.on_success = true
  slack.on_warning = false
  slack.on_failure = false
  slack.webhook_url = 'https://hooks.slack.com/services/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'
  slack.username = 'Platform Backups'
end

Notifier::PagerDuty.defaults do |pagerduty|
  pagerduty.on_success = false
  pagerduty.on_warning = true
  pagerduty.on_failure = true
  pagerduty.service_key = '660172eef6d147058b6e42974cf35d47'
  pagerduty.resolve_on_warning = true
end
EOL

if [ -d /etc/backup/.cache ]; then
  echo "cache already created"
else
  mkdir /etc/backup/.cache
fi

cat >/etc/backup/.cache/ctl7gd9wd0xtc896oqdfizjvb6ko7k <<EOL
---
- d3q993bx0l4hnn7
- hw6azs7jrgexfsx5
- KFqTf1bPrQbkhEsl
- zguO4hcmmLYaU9Ht
- 6oqdfizjvb6ko7k
- ctl7gd9wd0xtc89
EOL

if cmp -s files/platform-node-backup.rb /etc/backup/models/platform-node-backup.rb; then
  echo "Backup model file is identical, skipping copy"
else
  echo "Backup model file is modified, replacing."
  cp files/platform-node-backup.rb  /etc/backup/models/platform-node-backup.rb
fi

if cmp -s files/platform-node-backup-schedule.rb /etc/backup/platform-node-backup-schedule.rb; then
  echo "Backup schedule is identical, skipping copy"
else
  echo "Backup schedule is modified, replacing."
  label=$(cat attributes/hostname)
  cp files/platform-node-backup-schedule.rb /etc/backup/platform-node-backup-schedule.rb
  whenever -f /etc/backup/platform-node-backup-schedule.rb -w ${label}
fi
