# OpenVPN client

## Quick Start
volume mapping
```
/your/directory:/config/   (channels.txt list and scripts are found here)
/your/directory:/opt/ytdl/ (the folders for the youtube channels)
```
### Docker Compose
```
version: '3'
services:
    openvpn:
        restart: unless-stopped
        container_name: openvpn
        image: tetricz/openvpn-client
        volumes:
         - </your/directory>:/openvpn
        environment:
         - PROTO="udp"
         - PORT="1194"
         - LAN_NETWORK="192.168.1.0/24"
         - VPN_USER=""
         - VPN_PASS=""
```
### Docker Run
```
docker run -dit --cap-add=NET_ADMIN -e VPN_PASS="password" -e VPN_USER="username" -v </your/directory>:/openvpn --name openvpn tetricz/openvpn-client
```