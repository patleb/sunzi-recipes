if [ ! -d "/mnt/<%= @terraform[@attributes.blockstorage_volume]["name"] %>-part1" ]; then
  echo "Attaching DigitalOcean blockstorage volume <%= @terraform[@attributes.blockstorage_volume]["name"] %>"
  parted /dev/disk/by-id/scsi-0DO_Volume_<%= @terraform[@attributes.blockstorage_volume]["name"] %> mklabel gpt
  parted -a opt /dev/disk/by-id/scsi-0DO_Volume_<%= @terraform[@attributes.blockstorage_volume]["name"] %> mkpart primary ext4 0% 100%

  echo "Created partition, sleeping for 15 seconds"
  sleep 15

  echo "*yawn* \o/"
  echo "Mounting the new volume"
  mkfs.ext4 /dev/disk/by-id/scsi-0DO_Volume_<%= @terraform[@attributes.blockstorage_volume]["name"] %>-part1
  mkdir -p /mnt/<%= @terraform[@attributes.blockstorage_volume]["name"] %>-part1
  echo '/dev/disk/by-id/scsi-0DO_Volume_<%= @terraform[@attributes.blockstorage_volume]["name"] %>-part1 /mnt/<%= @terraform[@attributes.blockstorage_volume]["name"] %>-part1 ext4 defaults,nofail,discard 0 2' | sudo tee -a /etc/fstab
  mount -a
fi
