echo '========================================='
echo '=============ssh-keygen=================='
echo '========================================='
ssh-keygen


echo '========================================='
echo '=============ssh-copy-id================='
echo '========================================='
ssh-copy-id master.gamggi.io
ssh-copy-id server2@worker.gamggi.io


echo '========================================='
echo '=============pssh install================'
echo '========================================='
sudo apt install -y pssh
cat ~/.bashrc | grep parallel-ssh

if [ $? -ne 0 ] 
then
  echo 'alias pssh="parallel-ssh"' >> ~/.bashrc
  source ~/.bashrc
fi

echo '========================================='
echo '==============zsh install================'
echo '========================================='
sudo apt install -y zsh
sudo chsh -s /usr/bin/zsh


echo 'zsh 설치 완료'

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'oh-my-zsh 설치 완료'

sed -i "s/robbyrussell/agnoster/g" ~/.zshrc

echo '자동완성 플러그인'

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions

cat ~/.zshrc | grep zsh-autosuggestions

if [ $? -ne 0 ] 
then
  sed -i "s/(git/(git zsh-autosuggestions/g" ~/.zshrc
fi

echo 'pc 이름 제거'

cat ~/.zshrc | grep SSH_CLINET

if [ $? -ne 0 ] 
then
  cat << EOF >> ~/.zshrc
  prompt_context() { 
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then 
      prompt_segment black default "%(!.%{%F{yellow}%}.)$USER" 
    fi 
  }
EOF
fi

