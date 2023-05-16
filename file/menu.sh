#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/sreyaeve/IP-Register/main/ip | grep $MYIP | awk '{print $2}')
echo "Checking VPS"
#########################
IZIN=$(curl -sS https://raw.githubusercontent.com/sreyaeve/IP-Register/main/ip | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $MYIP ]; then
echo -e "\e[32mWelcome To Zen Area\e[0m"
else
echo -e "\e[31mPermission Denied!\e[0m";
exit 0
fi
#EXPIRED
expired=$(curl -sS https://raw.githubusercontent.com/sreyaeve/IP-Register/main/ip | grep $MYIP | awk '{print $3}')
echo $expired > /root/expired.txt
today=$(date -d +1day +%Y-%m-%d)
while read expired
do
	exp=$(echo $expired | curl -sS https://raw.githubusercontent.com/sreyaeve/IP-Register/main/ip | grep $MYIP | awk '{print $3}')
	if [[ $exp < $today ]]; then
		Exp2="\033[1;31mExpired\033[0m"
        else
        Exp2=$(curl -sS https://raw.githubusercontent.com/sreyaeve/IP-Register/main/ip | grep $MYIP | awk '{print $3}')
	fi
done < /root/expired.txt
rm /root/expired.txt
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[36m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[39m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
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
# VPS Information
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
DATE=$(date +'%Y-%m-%d')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""

today=`date -d "0 days" +"%Y-%m-%d"`

# CERTIFICATE STATUS
d1=$(date -d "$exp" +%s)
d2=$(date -d "$today" +%s)
certificate=$(( (d1 - d2) / 86400 ))
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
# usage
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/root/t1
bulan=$(date +%b)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /root/t1)" != '0' ]; then
    bulan=$(date +%b)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $10}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $4}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $7}')
else
    bulan=$(date +%Y-%m)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $8}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $2}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $5}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
fi
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(cat /usr/local/etc/xray/org)
WKT=$(cat /usr/local/etc/xray/timezone)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
#Status Service Menu
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
nginx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$nginx" = "active" ]; then
xnginx="${green}ON ${NC}"
else
xnginx="${red}OFF${NC}"
fi
xray=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$xray" = "active" ]; then
xxray="${green}ON ${NC}"
else
xxray="${red}OFF${NC}"
fi
clear 
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m             SYSTEM INFORMATION             \E[0m"
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e "\e[34m ISP           \e[0m:  $ISP"
echo -e "\e[34m Region        \e[0m:  $WKT"
echo -e "\e[34m IP VPS        \e[0m:  $IPVPS"
echo -e "\e[34m Domain        \e[0m:  $domain"
echo -e "\e[34m System Uptime \e[0m:  $uptime"			
echo -e "\e[34m RAM Usage     \e[0m:  $uram MB | $tram MB"
echo -e "\e[34m Client Name   \e[0m:  $Name"
echo -e "\e[34m Expired       \e[0m:  $Exp2 | $certificate Day Left"
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m              Running Services              \E[0m"
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e "${PURPLE}┏━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┓${NC}"
echo -e "${PURPLE}┃${NC}      \e[34mNginx\e[0m = $xnginx     ${PURPLE}┃${NC}      \e[34mXray\e[0m = $xxray     ${PURPLE}┃${NC}"
echo -e "${PURPLE}┗━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━┛${NC}"
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m               Bandwidth Usage              \E[0m"
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e "${BLUE} Today ${NC} : $todayd $today_v     ${BLUE} Monthly ${NC}: $month $month_v"
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                  MENU XRAY                 \E[0m"
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e   ""
echo -e " [\e[34m 01 \e[0m] Menu XRAY Vmess"
echo -e " [\e[34m 02 \e[0m] Menu XRAY Vless"
echo -e " [\e[34m 03 \e[0m] Menu XRAY Trojan"
echo -e " [\e[34m 04 \e[0m] Backup"
echo -e " [\e[34m 05 \e[0m] Restore"
echo -e " [\e[34m 06 \e[0m] Monitoring System Usage"
echo -e " [\e[34m 07 \e[0m] Change Domain"
echo -e " [\e[34m 08 \e[0m] Speedtest"
echo -e " [\e[34m 09 \e[0m] Restart Xray Services"
echo -e " [\e[34m 10 \e[0m] TCP BBR Setting"
echo -e " [\e[34m 11 \e[0m] DNS Setting"
echo -e " [\e[34m 12 \e[0m] Reboot VPS"
echo -e   ""
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m              SCRIPT INFORMATION            \E[0m"
echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e "\e[34mScript Name     \e[0m: Xray Lite Multiport"
echo -e "\e[34mAuthor          \e[0m: ZenVPN"
echo -e "\e[34mWhatsapp        \e[0m: 081977814343"
echo -e "\e[34mTelegram        \e[0m: t.me/zenvio"
echo -e "${PURPLE} ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; m-vmess ;;
2) clear ; m-vless ;;
3) clear ; m-trojan ;;
4) clear ; backup ;;
5) clear ; restore ;;
6) clear ; gotop ;;
7) clear ; m-domain ;;
8) clear ; speedtest ;;
9) clear ; restart ;;
10) clear ; menu-tcp ;;
11) clear ; dns ;;
12) clear ; reboot ;;
x) exit ;;
*) echo "Wrong Number Key" ; sleep 1 ; menu ;;
esac
