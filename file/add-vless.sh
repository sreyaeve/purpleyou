#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
clear
source /var/lib/zenhost/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
tls="$(cat ~/log-install.txt | grep -w "Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless WS none TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                 PANEL VLESS                \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                 PANEL VLESS                \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			v2ray-menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
clear
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m" | tee-a /etc/xraylog/log-vless-$user.txt
echo -e " \E[0;41;36m            DETAIL VLESS ACCOUNT            \E[0m" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m" | tee-a /etc/xraylog/log-vless-$user.txt
echo -e "Remarks        : ${user}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Domain         : ${domain}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "ISP            : ${ISP}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Region         : ${CITY}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Port TLS       : 443, 8443, 2053, 2083, 2087, 2096" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Port none TLS  : 80, 2082, 8880, 8080, 2095, 2086, 2052" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "id             : ${uuid}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Encryption     : none" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Network        : ws" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Path           : /vless" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Service Name   : vless-grpc" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Link TLS       : ${vlesslink1}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Link none TLS  : ${vlesslink2}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Link gRPC      : ${vlesslink3}" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "Expired On     : $exp" | tee -a /etc/xraylog/log-vless-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vless-$user.txt
echo "" | tee -a /etc/xraylog/log-vless-$user.txt
echo "Thanks for using ZenServices"
read -n 1 -s -r -p "Press any key to back"

m-vless
