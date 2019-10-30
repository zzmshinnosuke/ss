# ubuntu16 ss
sudo apt-get install python3-pip
sudo apt-get install python3-setuptools

pip3 install shadowsocks

wget https://raw.githubusercontent.com/zzmshinnosuke/ss/master/shadowsocks.json

ssserver -c ~/shadowsocks.json -d start

sudo ufw allow 22
sudo ufw allow 443
sudo ufw allow 8000
sudo ufw allow 8001
sudo ufw allow 8002
sudo ufw enable
