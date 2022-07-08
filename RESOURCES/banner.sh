#!/bin/bash 

# DISPLAY BANNER 
function display_banner() {
    figlet -w 120 "TRYENUM Bash Script" | lolcat
    figlet -w 160 "Ahmed Samir" 

    echo -e "[*] $(cyan "ENUMERATE HTTP PROTOCOL ${1}")"
    echo -e "[*] $(cyan "DISCOVERING DIRECTORIES OF \`http://${1}:${HTTP_DEFAULT_PORT}/\` WITH EXTENSIONS OF ${SCAN_DIRECTORY_FOR}")"
    echo -e "[*] $(cyan "NIKTO SCAN WEBSERVER OF ${1} HOST")"
    echo -e "[*] $(cyan "DISCOVERING OPEN PORTS FROM ${NMAP_SCAN_PORTSF_FROM} WITH -T5 OPTION")"
    echo -e "[*] $(cyan "CREWLING WEBSERVER COMMENTS AND HIDDEN DIRECTORIES")"
    echo -e "[*] $(cyan "DOWNLOAD WEBSERVER RESOURCES ${SPIDER_FILES_EXTENSIONS}")"
    echo -e "[*] $(cyan "NMAP --SCRIPT SCAN WITH T4 AS BECAUSE IT A TRYHACKME MACHINE")"
    echo ''
   
}