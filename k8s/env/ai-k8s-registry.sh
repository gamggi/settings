echo 'registry 만들기'

mkdir ~/ai-k8s-registry
sudo docker run --name 'ai-k8s-registry' -v /home/master1/ai-k8s-registry:/var/lib/registry/docker/registry/v2 -d -p 5000:5000 registry

echo 'registry container start'

sudo bash -c 'sed -i"" -e "7 i\ \ \"insecure-registries\" : [\"172.27.1.103:5000\"]," 
/etc/docker/daemon.json'
 
sudo systemctl restart docker


