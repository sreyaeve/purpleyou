#!/bin/bash
# My Telegram : https://t.me/zenvio
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
# Getting
clear
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
domain=$(cat /etc/xray/domain)
clear
email="kontol@gmail.com"
clear
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m               BACKUP DATA VPS              \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo ""
echo "Mohon Menunggu , Proses Backup sedang berlangsung !!"
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /etc/crontab backup/
cp /etc/ppp/chap-secrets backup/
cp -r /var/lib/zenhost/ backup/zenhost
cp -r /etc/xray backup/xray
cp -r /home/vps/public_html backup/public_html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "Detail Backup
 "${RED}┌───────────────────────────────────────┐${NC}"
    IP VPS        : $IP
    Domain        : $domain
    Link Backup   : $link
    Tanggal       : $date
 "${RED}└───────────────────────────────────────┘${NC}"
" mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
clear
echo -e "Detail Backup
 "${RED}┌───────────────────────────────────────┐${NC}"
    IP VPS        : $IP
    Domain        : $domain
    Link Backup   : $link
    Tanggal       : $date
 "${RED}└───────────────────────────────────────┘${NC}" 
"
echo "Silahkan copy Link dan restore di VPS baru"
echo "Terimakasih sudah menggunakan layanan ZenVPN"
