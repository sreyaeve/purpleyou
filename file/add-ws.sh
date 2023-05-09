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
tls="$(cat ~/log-install.txt | grep -w "Vmess WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess WS none TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                 PANEL VMESS                \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                 PANEL VMESS                \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
m-vmess
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m" -a /etc/xraylog/log-vmess-$user.txt
echo -e " \E[0;41;36m            DETAIL VMESS ACCOUNT            \E[0m" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m" -a /etc/xraylog/log-vmess-$user.txt
echo -e "Remarks        : ${user}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Domain         : ${domain}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "ISP            : ${ISP}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Region         : ${CITY}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Port TLS       : 443, 8443, 2053, 2083, 2087, 2096" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Port none TLS  : 80, 2082, 8880, 8080, 2095, 2086, 2052" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Port gRPC      : ${tls}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "id             : ${uuid}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "alterId        : 0" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Security       : auto" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Network        : ws" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Path           : /vmess • /multipath • (suka-suka)" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Service Name   : vmess-grpc" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Link TLS       : ${vmesslink1}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Link none TLS  : ${vmesslink2}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Link gRPC      : ${vmesslink3}" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "Expired On     : $exp" | tee -a /etc/xraylog/log-vmess-$user.txt
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/xraylog/log-vmess-$user.txt
echo "" | tee -a /etc/xraylog/log-vmess-$user.txt
echo "Thanks for using ZenServices"
read -n 1 -s -r -p "Press any key to back"

m-vmess
