#!/bin/bash -e 
# set -o nounset

source RESOURCES/colors.sh
source SCRIPTS/http-script-enum.sh 
source SCRIPTS/nmap-vuln-scan.sh
source RESOURCES/banner.sh 
source RESOURCES/create-intial-folders.sh
source RESOURCES/functions.sh


# DISPLAY BANNER 
display_banner $1

#CALL CREATE_DIRECTORIES TO START CREATING IMPORTANT FOLDERS 
create_directories

is_http_port_open $1

if [ "$?" = "0" ]
then 

    echo -e "[+] $(yellow HTTP) PROTOCOL IS $(green OPEN) ON PORT $(yellow 80)"
    
    echo -e "[*] $(yellow 'STARTING NIKTO') SCAN IN BACKGROUND" 
    nikto_scan $1
    
    echo -e "[*] $(yellow 'STARTING DIRECTORY DISCOVERING') USING $(yellow gobuster) TOOL IN BACKGROUND"
    directory_traverse $1

    echo -e "[*] START DISCOVERING ALL $(yellow OPEN) PORTS"
    nmap_port_scanner $1 
    wait

    echo '[*] STARTING NMAP FULL SCAN'
    nmap_full_scan $1

    echo -e "$(green "[+] SCAN COMPLETED SUCCESSFULLY")"    

    http_spider $1

fi


