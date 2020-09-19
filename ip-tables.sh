#!/bin/bash
#iptables --flush
#iptables --delete-chain
#iptables -t nat --flush
#iptables -t nat --delete-chain
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -o tun0 -p icmp -j ACCEPT
iptables -A OUTPUT -d "${LAN_NETWORK}" -j ACCEPT
iptables -A OUTPUT -p "${PROTO}" -m "${PROTO}" --dport "${PORT}" -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT