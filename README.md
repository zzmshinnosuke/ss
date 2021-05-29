# server
## 配置文件：  
只配置一个端口和密码  
```
{
"server":"::",
"server_port":443,
"local_address": "127.0.0.1",
"local_port":1080,
"password":"MyPass",
"timeout":600,
"method":"aes-256-cfb"
} 
```

server，可以直接配置ip。这样配置可以同时使用ipv4，ipv6，可以配置多个端口和密码  
```
{
 "server":"::",          # 同时支持 IPv4 和 IPv6
 "port_password": {
    "8000": "111111",
    "8001": "222222",
    "8002": "333333"
 },
 "method":"aes-256-cfb"
}
```

启动： `ssserver -c /etc/shadowsocks.json -d start`  
停止： `ssserver -c /etc/shadowsocks.json -d stop`  

## 防火墙  
centos：  
/etc/firewalld/  
在services 修改shadowsocks.xml  
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>shadowsocks</short>  
  <description>enable shadowsocks.</description>  
  <port protocol="tcp" port="8000"/>  
  <port protocol="tcp" port="443"/>  
  <port protocol="tcp" port="1080"/>  
</service>
重启防火墙服务
添加服务  ` firewall-cmd --add-service=shadowsocks `   （添加之后不用重启，重启又不在了）  
查看服务列表 ` firewall-cmd --list-services  ` 
` firewall-cmd --reload `  
 `service firewalld restart ` 

# client
windows： 安装shadowsocks客户端，需要安装新版的.net  
ubuntu:  安装和服务端一样  
 {  
   "server":"ip",  
   "server_port":port,  
   "password":"password",  
   "timeout":600,  
   "method":"aes-256-cfb"  
 }  
启动客户端  
`sslocal -c /etc/shadowsocks.json`  


# problems
## 解决pip install 时locale.Error: unsupported locale setting  
export LC_ALL=C   
## Ubuntu安装包时报错 E:Unable to locate package python3-pip    
apt-get update  
## ubuntu18 AttributeError: /usr/lib/x86_64-Linux-gnu/libcrypto.so.1.1: undefined symbol: EVP_CIPHER_CTX_cleanup
[参考](https://wangxin1248.github.io/linux/2018/04/ubuntu-install-shadowsocks.html)
## ubuntu 客户端启动时出现No JSON object could be decoded  
ubuntu:`sslocal -s 104.236.123.102 -p 443 -b 127.0.0.1 -l 1080 -k 723523 -m aes-256-cfb -t 300`
 
# ubuntu配置代理  
ubuntu设置全局代理：（可以在shell中翻墙）privoxy  
`apt-get install privoxy`  
配置privoxy  
`$ sudo gedit /etc/privoxy/config`  
 打开文件找到4.1节 listen-address，找到#listen-address 127.0.0.1:8118，取消注释  
找到5.2节forward-socks4, forward-socks4a, forward-socks5 and forward-socks5t，  
找到#forward-socks5t / 127.0.0.1:1080.取消注释。（10.0.0.32:1080）  

修改完之后，重启 privoxy：  
`$ sudo /etc/init.d/privoxy restart`  

设置代理  
export http_proxy="127.0.0.1:8118"  
export https_proxy="127.0.0.1:8118"  
export ftp_proxy="127.0.0.1:8118"  
保存退出后，终端也就可以使用代理了，我们来试一下 curl：  
wget www.google.com可以下载页面  
参考：https://ywnz.com/linuxjc/2687.html  
https://www.cnblogs.com/xiaocongcong888/p/9876422.html  
ubuntu   privoxy：https://blog.csdn.net/atyz123/article/details/63263956


[Android ss](http://github.com/shadowsocks/shadowsocks-android/releases)


