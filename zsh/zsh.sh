!/bin/bash

sudo apt install -y zsh
sudo chsh -s /usr/bin/zsh

echo 'zsh 설치 완료'

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'oh-my-zsh 설치 완료'

sed -i "s/robbyrussell/agnoster/g" ~/.zshrc

source ~/.zshrc
