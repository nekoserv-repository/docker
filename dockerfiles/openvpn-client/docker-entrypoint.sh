#!/usr/bin/env sh

## TODO
# - auto-detect proxy support (open ip + port)
# - tap support
# - open vpn port/port-range 52123-XXXXX
#

## init.
docker_network_v4=$(ip -o addr show dev eth0 | awk '$3 == "inet" {print $4}')
docker_network_v6=$(ip -o addr show dev eth0 | awk '$3 == "inet6" {print $4; exit}')

#vpn_port=$(awk '/^remote / {gsub(/[^[0-9]]*/,"");print}' /etc/openvpn/conf/openvpn.conf)
vpn_port=$(awk '/^remote / {print($3)}' /etc/openvpn/conf/openvpn.conf)
vpn_proto=$(awk '/^remote / && NF ~ /^[0-9]*$/ {print $NF}' /etc/openvpn/conf/openvpn.conf)
open_port="52123"

## INPUT
#v4
nft add chain ip filter INPUT { type filter hook input priority 0\; policy drop\; }
nft add rule ip filter INPUT ct state { established, related } accept
nft add rule ip filter INPUT iifname "lo" accept
nft add rule ip filter INPUT ip saddr ${docker_network_v4} accept
nft add rule ip filter INPUT iifname "tun*" tcp dport ${open_port} accept
nft add rule ip filter INPUT iifname "tun*" udp dport ${open_port} accept
#v6
nft add table ip6 filter
nft add chain ip6 filter INPUT { type nat hook input priority 0\; policy drop \;}
nft add rule ip6 filter INPUT ip6 saddr ${docker_network_v6} accept

## FORWARD
#v4
nft add chain ip filter FORWARD { type filter hook forward priority 0\; policy drop\; }
nft add rule ip filter FORWARD ct state { established, related } accept
nft add rule ip filter FORWARD iifname "lo" accept
nft add rule ip filter FORWARD ip saddr ${docker_network_v4} accept
nft add rule ip filter FORWARD ip daddr ${docker_network_v4} accept
#v6 - not supported


## OUTPUT
#v4
nft add chain ip filter OUTPUT { type filter hook output priority 0\; policy drop\; }
nft add rule ip filter OUTPUT ct state { established, related } accept
nft add rule ip filter OUTPUT oifname "lo" accept
nft add rule ip filter OUTPUT oifname "tun*" accept
nft add rule ip filter OUTPUT ip daddr ${docker_network_v4} accept
nft add rule ip filter OUTPUT udp dport 53 accept
nft add rule ip filter OUTPUT ${vpn_proto} dport ${vpn_port} accept
#v6
nft add chain ip6 filter OUTPUT { type nat hook output priority 0\; policy drop \;}
nft add rule ip6 filter OUTPUT ip6 daddr ${docker_network_v6} accept

exec /usr/sbin/openvpn --config /etc/openvpn/conf/openvpn.conf
