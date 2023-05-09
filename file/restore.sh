#!/bin/bash
# ==========================================
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
NC="\e[0m"
RED="\033[0;31m" 
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
# Getting
clear
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m              RESTORE DATA VPS              \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo ""
echo "This Feature Can Only Be Used According To Vps Data With This Autoscript"
echo "Please input link to your vps data backup file."
echo -e ""
read -rp "Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Starting to restore data..."
rm -f /root/backup/backup.zip &> /dev/null
sleep 1
cd /root/backup
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring passwd data..."
sleep 1
cp /root/backup/passwd /etc/ &> /dev/null
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring group data..."
sleep 1
cp /root/backup/group /etc/ &> /dev/null
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring shadow data..."
sleep 1
cp /root/backup/shadow /etc/ &> /dev/null
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring gshadow data..."
sleep 1
cp /root/backup/gshadow /etc/ &> /dev/null
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring chap-secrets data..."
sleep 1
cp /root/backup/chap-secrets /etc/ppp/ &> /dev/null
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring ss.conf data..."
sleep 1
cp /root/backup/ss.conf /etc/shadowsocks-libev/ss.conf &> /dev/null
echo -e "${CYAN}│${NC}  [ ${green}INFO${NC} ] • Restoring admin data..."
sleep 1
cp -r /root/backup/zenhost /var/lib/ &> /dev/null
cp -r /root/backup/.acme.sh /root/ &> /dev/null
cp -r /root/backup/ssnvpn /etc/ &> /dev/null
cp -r /root/backup/xray /etc/ &> /dev/null
cp -r /root/backup/public_html /home/vps/ &> /dev/null
cp -r /root/backup/crontab /etc/ &> /dev/null
cp -r /root/backup/cron.d /etc/ &> /dev/null

rm -rf /root/backup &> /dev/null
echo -e "$COLOR1│${NC}  [ ${green}INFO${NC} ] • Done... Successfully Pakbroo."
sleep 1
rm -f /root/backup/backup.zip &> /dev/null
echo -e "${CYAN}└─────────────────────────────────────────────────┘${NC}" 
echo ""
echo "Disarankan Reboot Setelah Restore"
echo ""
echo -ne "[ ${yell}WARNING${NC} ] Reboot Sekarang ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
