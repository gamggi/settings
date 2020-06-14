#!/bin/bash

pssh=false

end_msg(){
  echo ''
  echo "$1 $2 end. press any key..."
  read
}

install_ssh(){
  echo ''
  echo 'ssh-key generagte...'
  echo ''
  ssh-keygen

  echo ''
  echo 'ssh-copy-id...'
  echo ''
  #ssh-copy-id server2@worker.gamggi.io
  #ssh-copy-id master.gamggi.io

  end_msg make ssh-keygen
}

install_pssh(){
  echo ''
  echo 'pssh install...'
  echo ''
  sudo apt install -y pssh

  mkdir -p $PWD/host
  cat << EOF > $PWD/host/hostlist
EOF

  cat ~/.bashrc | grep parallel-ssh

  if [ $? -ne 0 ];  then
    echo 'alias pssh="parallel-ssh"' >> ~/.bashrc
    source ~/.bashrc
  fi

  FILE=~/.zshrc
  if [ -f "$FILE" ]; then
      cat ~/.zshrc | grep parallel-ssh

    if [ $? -ne 0 ];  then
      echo 'alias pssh="parallel-ssh"' >> ~/.zshrc
      source ~/.zshrc
    fi
  fi

  end_msg install pssh
}

install_tmux(){
  echo ''
  echo 'tmux install...'
  echo ''
  sudo apt install -y tmux

  end_msg install tmux
}

install_zsh(){
  echo ''
  echo 'zsh install...'
  echo ''
  sudo apt install -y zsh


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

  if [ $? -ne 0 ]; then
    cat << EOF >> ~/.zshrc
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}
EOF
  fi

  end_msg install zsh
}

install_keepalived(){
  echo ''
  echo 'keepalived install...'
  echo ''

  parallel-ssh -h $PWD/host/masterlist -P -i sudo apt install -y keepalived

  #parallel-ssh -H $(awk 'NR==1{print $1}' host/templist) -l $(awk 'NR==1{print $2}' host/templist) -P -i sudo mkdir -p /etc/keepalived && sudo cp keepalived.conf /etc/keepalived

  local i=1
  while read ip user; do
    scp "keepalived.conf.${i}" "${user}@${ip}:/home/${user}/keepalived.conf"
  done < host/masterlist

  end_msg install keepalived
}

install_haproxy(){
  echo ''
  echo 'haproxy install...'
  echo ''

  while read ip user; do
    scp haproxy.cfg "${user}@${ip}:/home/${user}/haproxy.cfg"
  done < host/masterlist

  parallel-ssh -h $PWD/host/masterlist -P -I < install_haproxy.sh

  end_msg install haproxy
}

install_master_utils(){
  while true
  do
    clear
    echo '========  insert master util menu  ============'
    echo '1. apt update'
    echo '2. ssh keygen & copy-id'
    echo '3. install parallel-ssh'
    echo '4. install zsh'
    echo '5. install tmux'
    echo '6. install keepalived'
    echo '7. install haproxy'
    echo '9. back to main menu'
    echo '0. exit'
    echo '==============================================='
    echo -n 'select menu : '
    read


    if [ $REPLY -eq 1 ]
    then
      sudo apt update
    elif [ $REPLY -eq 2 ]; then
      install_ssh
    elif [ $REPLY -eq 3 ]; then
      install_pssh
    elif [ $REPLY -eq 4 ]; then
      install_zsh
    elif [ $REPLY -eq 5 ]; then
      install_tmux
    elif [ $REPLY -eq 6 ]; then
      install_keepalived
    elif [ $REPLY -eq 7 ]; then
      install_haproxy
    elif [ $REPLY -eq 8 ]; then
      echo 'test'
      local i=1
      while read ip user; do
        mkdir -p "${user}@${ip}:/home/${user}"
        cp "keepalived.conf.${i}" "${user}@${ip}:/home/${user}/keepalived.conf.${i}"
        i=$((i+1))
      done < host/templist
      read
    elif [ $REPLY -eq 9 ]; then
      break
    elif [ $REPLY -eq 0 ]; then
      exit 0
    fi
  done
}

install_vim(){
  echo ''
  echo 'vim install...'
  echo ''

  echo "pssh mode : $pssh"

  if [ "$pssh" == true ]; then
    parallel-ssh -h $PWD/host/hostlist -P -I < install-vim.sh
  else
    ./install-vim.sh
  fi

  end_msg install vim
}

install_docker(){
  echo ''
  echo 'docker install...'
  echo ''

  echo "pssh mode : $pssh"

  if [ "$pssh" == true ]; then
    parallel-ssh -h $PWD/host/hostlist -P -I < install-docker.sh
  else
    ./install-docker.sh
  fi

  end_msg install docker
}

install_k8s(){
  echo ''
  echo 'k8s install...'
  echo ''

  echo "pssh mode : $pssh"

  if [ "$pssh" == true ]; then
    parallel-ssh -h $PWD/host/hostlist -P -I < install-k8s.sh
  else
    ./install-k8s.sh
  fi

  end_msg install k8s
}

install_helm(){
  echo ''
  echo 'helm install...'
  echo ''

  echo "pssh mode : $pssh"

  if [ "$pssh" == true ]; then
    parallel-ssh -h $PWD/host/hostlist -P -I < install-helm.sh
  else
    ./install-helm.sh
  fi

  end_msg install helm
}


install_utils(){
  while true
  do
    clear
    echo '===========  insert util menu  ================'
    echo '1. apt update'
    echo '2. install vim'
    echo '3. install docker'
    echo '4. install k8s'
    echo '5. install helm'
    echo "8. change pssh mode [current status : $pssh]"
    echo '9. back to main menu'
    echo '0. exit'
    echo '==============================================='
    echo -n 'select menu : '
    read


    if [ $REPLY -eq 1 ]
    then
      sudo apt update
    elif [ $REPLY -eq 2 ]; then
      install_vim
    elif [ $REPLY -eq 3 ]; then
      install_docker
    elif [ $REPLY -eq 4 ]; then
      install_k8s
    elif [ $REPLY -eq 5 ]; then
      install_helm
    elif [ $REPLY -eq 8 ]; then
      if [ "$pssh" == "true" ]; then
        pssh=false
      else
        pssh=true
      fi
    elif [ $REPLY -eq 9 ]; then
      break
    elif [ $REPLY -eq 0 ]; then
      exit 0
    fi
  done
}

manage_k8s(){
  while true
  do
    clear
    echo '============  manage k8s menu  ================'
    echo '1. install metalLB'
    echo '2. install dynamic provisioning'
    echo '3. install docker'
    echo '4. install k8s'
    echo "8. change pssh mode [current status : $pssh]"
    echo '9. back to main menu'
    echo '0. exit'
    echo '==============================================='
    echo -n 'select menu : '
    read


    if [ $REPLY -eq 1 ]
    then
      sudo apt update
    elif [ $REPLY -eq 2 ]; then
      install_vim
    elif [ $REPLY -eq 3 ]; then
      install_docker
    elif [ $REPLY -eq 4 ]; then
      install_k8s
    elif [ $REPLY -eq 5 ]; then
      install_tmux
    elif [ $REPLY -eq 8 ]; then
      if [ "$pssh" == "true" ]; then
        pssh=false
      else
        pssh=true
      fi
    elif [ $REPLY -eq 9 ]; then
      break
    elif [ $REPLY -eq 0 ]; then
      exit 0
    fi
  done
}


while true
do
  clear
  echo '==============================================='
  echo '1. install master utils - ssh & copy, tmux, zsh'
  echo '2. install utils - ssh & copy, tmux, zsh'
  echo '3. manage k8s - init, join, utils'
  echo '0. quit'
  echo '==============================================='
  echo -n 'select menu : '
  read

  if [ $REPLY -eq 1 ]
  then
    install_master_utils
  elif [ $REPLY -eq 2 ]; then
    install_utils
  elif [ $REPLY -eq 3 ]; then
    manage_k8s
  elif [ $REPLY -eq 0 ]; then
    exit
  fi
done
