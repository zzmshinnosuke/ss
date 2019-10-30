yum install python-setuptools && easy_install pip
pip install shadowsocks

wget https://raw.githubusercontent.com/zzmshinnosuke/ss/master/shadowsocks.json

ssserver -c shadowsocks.json -d start

yum install firewalld
