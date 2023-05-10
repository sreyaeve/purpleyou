NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
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
NUMBER_OF_CLIENTS=$(grep -c -E "#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m         LOG CREATE TROJAN ACCOUNTS         \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e "  ${YB}You have no existing clients!${NC}"
echo -e "${PURPLE}————————————————————————————————————————————————————${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-trojan
fi
clear
    echo -e "${PURPLE}╒════════════════════════════════════════════╕\033[0m"
    echo -e " \E[0;41;36m         LOG CREATE TROJAN ACCOUNTS         \E[0m"
    echo -e "${PURPLE}╘════════════════════════════════════════════╛\033[0m"
echo -e " ${YB}User  Expired${NC}  "
echo -e "${PURPLE}————————————————————————————————————————————————————${NC}"
grep -E "#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${YB}tap enter to go back${NC}"
echo -e "${PURPLE}————————————————————————————————————————————————————${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
m-trojan
else
clear
echo -e "`cat "/etc/xraylog/log-trojan-$user.txt"`"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-trojan
fi
