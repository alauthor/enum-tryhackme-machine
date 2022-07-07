#!/bin/bash 

# DISPLAY BANNER 
function display_banner() {
    figlet -w 120 "TRYENUM Bash Script" | lolcat
    figlet -w 160 "Ahmed Samir" 

    echo -e "$(cyan "[*] ENUMERATE HTTP PROTOCOL ${1}")"
    echo -e "$(cyan "[*] ENUMERATE HTTP DIRECTORIES OF \`http://${1}:${HTTP_DEFAULT_PORT}/\`")"
    echo -e "$(cyan "[*] NIKTO SCAN WEBSERVER OF ${1} HOST")"
    echo -e "$(cyan "[*] NMAP SCAN HOST ${1} MACHINE")"
    echo ''
   
}