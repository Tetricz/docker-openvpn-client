FROM alpine:3.12

LABEL maintainer="github.com/Tetricz"

ENV PORT="1194" \
    LAN_NETWORK="192.168.1.0/24" \
    VPN_USER="" \
    VPN_PASS="" \
    PROTO="udp" \
    docker_GATEWAY="172.17.0.1" \
    docker_SUBNET="172.17.0.0/16"

RUN apk --no-cache add bash curl iptables openvpn openresolv openrc jq

ADD ./update-resolv-conf /etc/openvpn/
ADD ./tun.sh /home/
ADD ./ip-tables.sh /home/
ADD ./entrypoint.sh /

RUN chmod +x ./entrypoint.sh /home/* /etc/openvpn/*
RUN mkdir -p /openvpn

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -LSs 'https://api.ipify.org'

ENTRYPOINT [ "./entrypoint.sh" ]