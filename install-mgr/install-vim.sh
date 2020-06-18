sudo apt install -y vim
cat ~/.vimrc | grep number

if [ $? -ne 0 ];  then
  echo 'set number' >> ~/.vimrc
fi
