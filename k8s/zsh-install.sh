sudo apt install -y zsh

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


echo "install"

sudo apt install zsh-syntax-highlighting

echo 'source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
echo 'highlighting complete!'

echo 'theme 변경'

sed -i "s/robbyrussell/agnoster/g" ~/.zshrc


echo '==========================================='
echo '    install zsh-autosuggestions plugin'
echo '==========================================='
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i "s/plugins=(git/plugins=(git zsh-autosuggestions/g" ~/.zshrc



echo '==========================================='
echo '    install zsh-kubectl-prompt'
echo '==========================================='
git clone https://github.com/superbrothers/zsh-kubectl-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-kubectl-prompt

sed -i "s/plugins=(git/plugins=(git zsh-kubectl-prompt/g" ~/.zshrc


echo '==========================================='
echo '           k8s auto complete'
echo '==========================================='



echo 'alias k=kubectl' >> ~/.zshrc
echo 'complete -F __start_kubectl k' >> ~/.zshrc
echo '[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)' >> ~/.zshrc
echo 'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247"' >> ~/.zshrc

echo 'autoload -U colors; colors' >> ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-kubectl-prompt/kubectl.zsh' >> ~/.zshrc

echo 'function right_prompt() {
  local color="white"

  if [[ "$ZSH_KUBECTL_USER" =~ "admin" ]]; then
    color=red
  fi  

  echo "%{$fg[$color]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}"
}' >> ~/.zshrc
echo 'RPROMPT='"'"'$(right_prompt)'"'"'' >> ~/.zshrc

echo "alias ka='kubectl --context ams'" >> ~/.zshrc
echo "alias kb='kubectl --context busan'" >> ~/.zshrc
echo "alias kans='k config set-context ams --namespace '" >> ~/.zshrc
echo "alias kc='k --context colombo '" >> ~/.zshrc
echo "alias kcns='k config set-context colombo --namespace '" >> ~/.zshrc

zsh 
