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
#echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc


echo '==========================================='
echo '              PC 명 제거'
echo '==========================================='
echo 'prompt_context() {' >> ~/.zshrc
echo '  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then' >> ~/.zshrc
echo '    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"' >> ~/.zshrc
echo '  fi' >> ~/.zshrc
echo '}' >> ~/.zshrc



echo '==========================================='
echo '    install zsh-kubectl-prompt'
echo '==========================================='
git clone https://github.com/superbrothers/zsh-kubectl-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-kubectl-prompt

sed -i "s/plugins=(git/plugins=(git zsh-kubectl-prompt/g" ~/.zshrc

echo 'autoload -U colors; colors' >> ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-kubectl-prompt/kubectl.zsh' >> ~/.zshrc
echo 'RPROMPT="%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}"' >> ~/.zshrc



echo '==========================================='
echo '           k8s auto complete'
echo '==========================================='

echo 'alias k=kubectl' >> ~/.zshrc
echo 'complete -F __start_kubectl k' >> ~/.zshrc
echo '[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)' >> ~/.zshrc

echo 'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247"' >> ~/.zshrc

zsh

