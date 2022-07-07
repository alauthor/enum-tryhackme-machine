#!/bin/bash


PORTS_FILE="grep_open_port_scanner"

function nmap_port_scanner () {
    nmap -sS -p- $1 -oG SCAN/NMAP/grep_open_port_scanner > /dev/null 2> /dev/null &
}

function grep_open_ports() {
    if [ -e SCAN/NMAP/$PORTS_FILE ]
    then
        OPEN_PORTS=$(cat SCAN/NMAP/$PORTS_FILE | grep -Eo "[0-9]+/open" | grep -Eo "[0-9]+" | sed -z 's/\n/,/g;s/,$/\n/') 
        echo -e "[+] OPEN PORTS \`$(green ${OPEN_PORTS})\`"
    else 
        return 1 
    fi

}

function nmap_full_scan() { 
    # call grep open ports to start dealing with the string OPEN_PORTS
    grep_open_ports

    if [ "$?" = "0" ]
    then 
        nmap -sT -p${OPEN_PORTS} -T4 -sC --script="*vuln*" -sV -O $1 -oN SCAN/NMAP/full_scan_result> /dev/null 2> /dev/null &
    else 
        echo "[-] NOT ABLE TO EXTRACT PORTS"
    fi
}