#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
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
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
clear
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m                 MENU VMESS                 \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e ""
echo -e " [\e[36m•1\e[0m] Create Vmess Account "
echo -e " [\e[36m•2\e[0m] Create Trial Vmess Account "
echo -e " [\e[36m•3\e[0m] Renew Vmess Account "
echo -e " [\e[36m•4\e[0m] Delete Vmess Account "
echo -e " [\e[36m•5\e[0m] Check Vmess User Online "
echo -e " [\e[36m•6\e[0m] Check Detail Vmess User Account "
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-ws ; exit ;;
2) clear ; trialvmess ; exit ;;
3) clear ; renew-ws ; exit ;;
4) clear ; del-ws ; exit ;;
5) clear ; cek-ws ; exit ;;
6) clear ; log-vmess ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo "Tekan Yang Bener Dlogok" ; sleep 1 ; m-vmess ;;
esac
