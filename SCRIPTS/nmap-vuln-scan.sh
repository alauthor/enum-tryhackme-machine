#!/bin/bash


PORTS_FILE="grep_open_port_scanner"

function nmap_port_scanner () {
    echo -e "[*] $(yellow "START DISCOVERING OPEN PORTS FROM 1-65535")"
    nmap -sS -p- -T5 $1 -oG SCAN/NMAP/grep_open_port_scanner > /dev/null &
    # wait for this process only to get done 
    wait $!
}

function grep_open_ports() {
    
    nmap_port_scanner $1 
    
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
    grep_open_ports $1

    echo "[*] $(yellow STARTING) NMAP FULL SCAN"

    if [ "$?" = "0" ]
    then 
        nmap -sT -p${OPEN_PORTS} -T4 -A -sV -O $1 -oN SCAN/NMAP/full_scan_result >/dev/null &
        wait
    else 
        echo "[-] NOT ABLE TO EXTRACT PORTS"
    fi
}