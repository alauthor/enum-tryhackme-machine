#!/bin/bash

# start to see if http is open 

HTTP_DEFAULT_PORT=80
FIRST_LINES_FROM_WORDLIST_TO_SCAN=5000
SCAN_DIRECTORY_FOR="php,txt,html"
PORTS_FILE="grep_open_port_scanner"

function create_directories() {
    echo "[+] CREATING SCAN/NMAP FOLDER FOR NMAP RESULT SCAN" 2>/dev/null
    mkdir -p SCAN/NMAP
    echo '[+] CREATING SCAN/NIKTO SCAN FOLDER'
    mkdir -p SCAN/NIKTO 2>/dev/null
    echo '[+] CREATING SCAN/NIKTO SCAN FOLDER'
    mkdir -p SCAN/TRAVERSING 2>/dev/null
}

function directory_traverse(){
    if [ -e /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt ]
    then
        head -n $FIRST_LINES_FROM_WORDLIST_TO_SCAN /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt | gobuster dir -u "http://${1}:${HTTP_DEFAULT_PORT}/" -w - -x $SCAN_DIRECTORY_FOR -o SCAN/TRAVERSING/gobuster_result_scan.txt &
    else 
       echo "[-] FILE directory-list-2.3-medium.txt DOESN'T EXIST"
    fi
}

function nikto_scan() {
    nikto -h "http://${1}:${HTTP_DEFAULT_PORT}/" -output SCAN/NIKTO/result.txt & 
}

function nmap_port_scanner () {
    nmap -sS -p- $1 -oG SCAN/NMAP/grep_open_port_scanner
}

function grep_open_ports() {
    if [ -e SCAN/NMAP/$PORTS_FILE ]
    then
        OPEN_PORTS=$(cat SCAN/NMAP/$PORTS_FILE | grep -Eo "[0-9]+/open" | grep -Eo "[0-9]+" | sed -z 's/\n/,/g;s/,$/\n/') 
    else 
        return 1 
    fi

}

function nmap_full_scan() { 
    # call grep open ports to start dealing with the string OPEN_PORTS
    grep_open_ports

    if [ "$?" = "0" ]
    then 
        nmap -sT -p${OPEN_PORTS} -T4 -sC --script="*vuln*" -sV -O $1 -oN SCAN/NMAP/full_scan_result 
    else 
        echo "[-] NOT ABLE TO EXTRACT PORTS"
    fi
}

function clear_terminal() {
    echo '[*] CLEARING TERMINAL'
    sleep 2
    clear
}

CALL CREATE_DIRECTORIES TO START CREATING IMPORTANT FOLDERS 
create_directories

START PORT 80 SCANNING .
nmap -sS -p${HTTP_DEFAULT_PORT} $1 -oN SCAN/NMAP/nmap-port-80-scan.nmap
wait


if [ "$?" = "0" ]
then 

    echo '[+] HTTP PROTOCOL IS OPEN ON PORT 80'
    
    echo "[+] STARTING NIKTO SCAN IN BACKGROUND"
    nikto_scan $1
    
    echo '[*] STARTING DIRECTORY DISCOVERING USING gobuster TOOL IN BACKGROUND'
    directory_traverse $1

    echo '[*] START DISCOVERING ALL OPEN PORTS'
    nmap_port_scanner $1 
    wait

    echo '[*] STARTING NMAP FULL SCAN'
    nmap_full_scan $1

    clear_terminal

fi


