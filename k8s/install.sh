sudo apt install -y vim
echo 'set number' >> ~/.vimrc
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt install -y kubectl=1.20.2-00 kubeadm=1.20.2-00 kubelet=1.20.2-00
sudo apt-mark hold kubelet kubeadm kubectl


echo 'swap off'
sudo swapoff -a
sudo sed -i "s/\/swap/#\/swap/g" /etc/fstab

