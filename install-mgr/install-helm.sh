sudo snap install helm --classic

sudo sed -e 's|PATH="\(.*\)"|PATH="/snap/bin:\1"|g' -i /etc/environment

source /etc/environment
