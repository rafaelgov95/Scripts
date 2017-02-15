#!/bin/bash

### BEGIN INIT INFO
# Provides:          firewall.sh
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start firewall.sh at boot time
# Description:       Enable service provided by firewall.sh.
### END INIT INFO

#Apagar configurações 
iptables -t nat -F
# Abre porta 22 no firewall
iptables -A OUTPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#Comunicação entre vpn redirecionando trafego da tun0 para wlan0
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD -i wlan0 -o tun0 -j ACCEPT
iptables -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED -j AC$

