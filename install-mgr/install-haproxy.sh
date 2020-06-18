sudo apt install -y haproxy

FILE=~/haproxy.cfg

if [ -f "$FILE" ]; then
  sudo mkdir -p /etc/haproxy
  sudo cp "$FILE" /etc/haproxy/

  echo 'haproxy.cfg copied'

  sudo systemctl restart haproxy
fi
end_msg install haproxy