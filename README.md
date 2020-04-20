
1.解决pip install 时locale.Error: unsupported locale setting  
export LC_ALL=C   
2.Ubuntu安装包时报错 E:Unable to locate package python3-pip    
apt-get update  


安装
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
sudo apt-get update
sudo apt install shadowsocks-libev


sudo vim /etc/shadowsocks-libev/config.json
{
 "server":["[::]","0.0.0.0"],
 "server_port":8001,
 "password":"111111",
 "timeout":600,
 "method":"aes-256-gcm"
}


启动：systemctl restart shadowsocks-libev

想要以后每次重启（Linux的CentOS）服务器时都可以自动启动此ss服务，则可以去：

    设置开机启动：systemctl enable shadowsocks-libev

其他相关命令：

    查看状态：systemctl status shadowsocks-libev

    查看日志：journalctl -u shadowsocks-libev

    重启：systemctl restart shadowsocks-libev


用shadowsocks-libev实现多账号/多用户

上述创建的ss服务，只有一个（账号）密码，只能供一个人用，或者说，如果多个人使用，则使用的是同一个（账号）密码，显得很不方便和不安全。

如果想要多个用户每人有不同的账号（密码），则可以：用shadowsocks-libev实现多账号/多用户

新建另外一个配置文件，比如：

/etc/shadowsocks-libev/config2.json

内容和之前一致，只是端口号server_port和密码password改了一下即可：

{
    "server": "0.0.0.0",
    "server_port": 21501,
    "password": "passowrd2",
    "method": "aes-256-cfb",
    "timeout": 300,
    "mode": "tcp_and_udp"}Copy

    注意: 端口号不要和系统中其他服务的端口号冲突了。

另外再去用：

setsid ss-server -c /etc/shadowsocks-libev/config2.json -uCopy

启用新端口对应的ss服务。
