#!/bin/bash

source RESOURCES/settings.sh
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

    echo -e "[+] $(green "HTTP PROTOCOL IS OPEN ON PORT ${HTTP_DEFAULT_PORT}")"
    nikto_scan $1
    directory_traverse $1
    http_spider $1 
    cewl_webserver $1
    nmap_full_scan $1
    
    echo -e "[+] $(green "DONE SPIDERING WEBSERVER")"    
    echo -e "[*] $(green "GENERATING WEBSERVER WORDLIST COMPLETED SUCCESSFULLY")"
    echo -e "[+] $(green "NIKTO SCAN COMPLETED SUCCESFULLLY")" 

    if [ "$0" = "0" ]
    then
        echo -e "$(green "[+] SCAN COMPLETED SUCCESSFULLY")"   
    fi 

fi


