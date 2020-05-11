sudo apt install -y nfs-common nfs-kernel-server rpcbind portmap
sudo su
chmod -R 777 /mnt/hdd	# NFS 서버를 제공할 디렉토리의 권한설정
echo '/mnt/hdd 172.27.0.0/16(rw,insecure,no_subtree_check,async,no_root_squash)' >> /etc/exports		# nfs 서버 환경설정 : 공유디렉토리 클라이언트주소(옵션)
exportfs -a
systemctl restart nfs-kernel-server
