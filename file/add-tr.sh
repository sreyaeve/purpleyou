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
tls="$(cat ~/log-install.txt | grep -w "Trojan WS TLS" | cut -d: -f2|sed 's/ //g')"
ntls="$(cat ~/log-install.txt | grep -w "Trojan WS none TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                PANEL TROJAN                \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"

		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                PANEL TROJAN                \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			m-trojan
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

trojanlink1="trojan://${uuid}@${domain}:${tls}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@isi_bug_disini:${tls}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink2="trojan://${uuid}@isi_bug_disini:${ntls}?path=%2Ftrojan-ws&security=none&host=${domain}&type=ws#${user}"
systemctl restart xray
clear
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
    echo -e " \E[0;41;36m            DETAIL TROJAN ACCOUNT           \E[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Remarks        : ${user}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Host/IP        : ${domain}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "ISP            : ${ISP}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Region         : ${CITY}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Port TLS       : 443, 8443, 2053, 2083, 2087, 2096" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Port none TLS  : 80, 2082, 8880, 8080, 2095, 2086, 2052" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Port gRPC      : ${tls}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Key            : ${uuid}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Path           : /trojan-ws" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Service Name   : trojan-grpc" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Link TLS       : ${trojanlink}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Link none TLS  : ${trojanlink2}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Link gRPC      : ${trojanlink1}" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "Expired On     : $exp" | tee -a /etc/xraylog/log-trojan-$user.txt
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-trojan-$user.txt
echo "" | tee -a /etc/xraylog/log-trojan-$user.txt
echo "Thanks for using ZenServices"
read -n 1 -s -r -p "Press any key to back"
m-trojan
fi
