!/bin/bash

sudo apt install -y zsh
sudo chsh -s /usr/bin/zsh

echo 'zsh 설치 완료'

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'oh-my-zsh 설치 완료'

sed -i "s/robbyrussell/agnoster/g" ~/.zshrc

echo '자동완성 플러그인'

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
sed -i "s/(git/(git zsh-autosuggestions/g" ~/.zshrc

echo 'pc 이름 제거'

cat << EOF >> ~/.zshrc
prompt_context() { 
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then 
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER" 
  fi 
}
EOF



source ~/.zshrc
