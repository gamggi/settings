sudo swapoff -a
sudo sed -i "s/\/swap/#\/swap/g" /etc/fstab
