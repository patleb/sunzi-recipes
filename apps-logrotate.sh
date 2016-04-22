# Upload logrotate configuration

# It's safe to just add and not check it if exists because we would
# want to override this if it is already there.

mv files/apps-logrotate.conf /etc/logrotate.d/apps-logrotate.conf
