#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
apt install jq curl -y
apt install curl sudo -y
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir /etc/xraylog >> /dev/null 2>&1
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/scdomain
touch /etc/v2ray/scdomain

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
clear
echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Alright good ... installation file is ready"
sleep 0.5
echo -ne "[ ${green}INFO${NC} ] Check Ijin Dulu Loading...."
sleep 2
echo -e "${green}Permission Accepted${NC}"
sleep 3
clear
mkdir /user >> /dev/null 2>&1
apt install resolvconf network-manager dnsutils bind9 -y
cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=8.8.8.8 8.8.4.4
Domains=~.
ReadEtcHosts=yes
END
systemctl enable resolvconf
systemctl enable systemd-resolved
systemctl enable NetworkManager
rm -rf /etc/resolv.conf
rm -rf /etc/resolvconf/resolv.conf.d/head
echo "
nameserver 127.0.0.53
" >> /etc/resolv.conf
echo "
" >> /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf
systemctl restart systemd-resolved
systemctl restart NetworkManager
echo "Google DNS" > /user/current
mkdir -p /var/lib/zenhost >/dev/null 2>&1
echo "IP=" >> /var/lib/zenhost/ipvps.conf

mkdir -p /usr/local/etc/xray
rm /usr/local/etc/xray/city >> /dev/null 2>&1
rm /usr/local/etc/xray/org >> /dev/null 2>&1
rm /usr/local/etc/xray/timezone >> /dev/null 2>&1

curl -s ipinfo.io/city >> /usr/local/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /usr/local/etc/xray/org
curl -s ipinfo.io/timezone >> /usr/local/etc/xray/timezone
echo ""
clear
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
echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;33;44;1m           This Autoscript Is Paid          \E[0m"
echo -e " \E[0;36;44;1m             You Can Contact Me             \E[0m"
echo -e " \E[0;36;44;1m           WhatsApp : 081977814343          \E[0m"
echo -e " \E[0;36;44;1m           Telegram : t.me/zenvio           \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;36;44;1m              Please Choice One             \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
echo -e ""
echo -e "${GREEN}1${NC}. Your Own Domain"
echo -e "${GREEN}2${NC}. Our Domain"
read -p "$( echo -e "${GREEN}Please Input ! ${NC}(${YELLOW}1/2${NC})${NC} " )" choose_domain


# // Validating Automatic / Private
if [[ $choose_domain == "2" ]]; then # // Using Automatic Domain
# // String / Request Data
sub=$(</dev/urandom tr -dc a-z | head -c4)
DOMAIN=vpnpro.my.id
SUB_DOMAIN=xray.${sub}.vpnpro.my.id
CF_ID=cloudflaredomainpanel@gmail.com
CF_KEY=91b7451cf8fed9cbc1c4ca31931ffce8741f6
set -euo pipefail
IP=$(curl -sS ifconfig.me);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
     
echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
	echo "$SUB_DOMAIN" > /etc/xray/scdomain
	echo "$SUB_DOMAIN" > /etc/xray/domain
	echo "$SUB_DOMAIN" > /etc/v2ray/domain
echo "IP=$SUB_DOMAIN" > /var/lib/zenhost/ipvps.conf
sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "Domain added.."
sleep 3
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain

# // ELif For Selection 1
elif [[ $choose_domain == "1" ]]; then

# // Clear
clear
clear && clear && clear
clear;clear;clear

echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;33;44;1m           This Autoscript Is Paid          \E[0m"
echo -e " \E[0;36;44;1m             You Can Contact Me             \E[0m"
echo -e " \E[0;36;44;1m           WhatsApp : 081977814343          \E[0m"
echo -e " \E[0;36;44;1m           Telegram : t.me/zenvio           \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;36;44;1m              Input Your Domain             \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
echo " "
read -rp "Input domain kamu : " -e dns
    if [ -z $dns ]; then
        echo -e "
        Nothing input for domain!
        Then a random domain will be created"
    else
        echo "$dns" > /root/scdomain
	echo "$dns" > /etc/xray/scdomain
	echo "$dns" > /etc/xray/domain
	echo "$dns" > /etc/v2ray/domain
	echo $dns > /root/domain
        echo "IP=$dns" > /var/lib/zenhost/ipvps.conf
    fi

# // Else Do
else
    echo -e "${EROR} Please Choose 1 & 2 Only !"
    exit 1
fi
sts=jancok
echo $sts > /home/email

clear   
#install Menu
echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;36;44;1m              Installing Started            \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
sleep 0.5
clear
wget https://raw.githubusercontent.com/sreyaeve/purpleyou/main/installer/installmenu.sh && chmod +x installmenu.sh && ./installmenu.sh
#install Backup Menu
echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;36;44;1m            Installing Backup Set           \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
sleep 0.5
clear
wget https://raw.githubusercontent.com/sreyaeve/purpleyou/main/installer/installbackup.sh && chmod +x installbackup.sh && ./installbackup.sh
#Instal Xray Menu
echo -e "${CYAN}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;36;44;1m           Installing Xray Services         \E[0m"
echo -e "${CYAN}╘════════════════════════════════════════════╛\033[0m"
sleep 0.5
clear
wget https://raw.githubusercontent.com/sreyaeve/purpleyou/main/installer/installxray.sh && chmod +x installxray.sh && ./installxray.sh
wget https://raw.githubusercontent.com/sreyaeve/purpleyou/main/file/tools.sh;chmod +x tools.sh;./tools.sh
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

#install htop
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
serverV=$( curl -sS https://raw.githubusercontent.com/sreyaeve/purpleyou/main/version/versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
history -c
curl -sS ifconfig.me > /etc/myipvps
clear
echo " "
echo "=====================-[ AutoScript by Zenvpn ]-===================="
echo ""
echo -e "${RED}┌───────────────────────────────────────┐${NC}"
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - Nginx                    : 81" | tee -a log-install.txt
echo "   - Vmess WS TLS             : 443" | tee -a log-install.txt
echo "   - Vless WS TLS             : 443" | tee -a log-install.txt
echo "   - Trojan WS TLS            : 443" | tee -a log-install.txt
echo "   - Vmess WS none TLS        : 80" | tee -a log-install.txt
echo "   - Vless WS none TLS        : 80" | tee -a log-install.txt
echo "   - Trojan WS none TLS       : 80" | tee -a log-install.txt
echo "   - Vmess gRPC               : 443" | tee -a log-install.txt
echo "   - Vless gRPC               : 443" | tee -a log-install.txt
echo "   - Trojan gRPC              : 443" | tee -a log-install.txt
echo ""
echo "   - Alternative Port"
echo "   - Port TLS                : 8443, 2053, 2083, 2087, 2096"
echo "   - Port none TLS           : 2082, 8880, 8080, 2095, 2086, 2052"
echo ""
echo -e "${RED}└───────────────────────────────────────┘${NC}" 
echo ""
echo "=====================-[ AutoScript by Zenvpn ]-===================="
echo -e ""
echo ""
echo "" | tee -a log-install.txt
rm /root/setup.sh >/dev/null 2>&1
rm /root/installxray.sh >/dev/null 2>&1
rm /root/installmenu.sh >/dev/null 2>&1
rm /root/installbackup.sh >/dev/null 2>&1
rm /root/tools.sh >/dev/null 2>&1
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "
"
echo -ne "[ ${yell}WARNING${NC} ] reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi





