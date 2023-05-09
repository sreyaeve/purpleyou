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
clear 
	  echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m            RESTART SERVICE MENU            \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e ""
echo -e " [\e[36m•1\e[0m] Restart All Services"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e   ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo -e   ""
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " Restart
echo -e ""
sleep 1
clear
case $Restart in
                1)
                clear
	  echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m             RESTARTING SERVICE             \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
                echo -e ""
                echo -e "[ \033[36mInfo\033[0m ] Restart Begin"
                echo ""
                sleep 1
                echo -e "[ \033[36mInfo\033[0m ] Restarting Vnstat"
                systemctl restart vnstat
                sleep 2
                echo -e "[ \033[36mInfo\033[0m ] Restarting Cron"
                systemctl restart cron
                sleep 2
                echo -e "[ \033[36mInfo\033[0m ] Restarting Nginx"
                systemctl restart nginx
                sleep 2
                echo -e "[ \033[36mInfo\033[0m ] Restarting Xray"
                systemctl restart xray
                systemctl restart xray.service
                sleep 2
                echo -e "[ \033[36mInfo\033[0m ] ALL Service Restarted"
                echo ""
                echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo ""
                read -n 1 -s -r -p "Press Any Key To Back"
                restart
                ;;                                                        
                0)
                menu
                exit
                ;;
                x)
                clear
                exit
                ;;
                *) echo -e "" ; echo "Tekan Yang Bener Dlogok" ; sleep 1 ; restart ;;               
        esac
