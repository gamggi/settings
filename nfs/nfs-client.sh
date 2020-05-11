sudo apt install -y nfs-common
sudo su
mkdir /mnt/data
mount -t nfs 172.27.1.103:/mnt/hdd /mnt/data
echo '172.27.1.103:/mnt/hdd /mnt/data nfs defaults,nolock 1 2' >> /etc/fstab
