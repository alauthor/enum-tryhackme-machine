#!/bin/bash


function nmap_port_scanner () {
    echo -e "[*] $(yellow "START DISCOVERING OPEN PORTS FROM 1-65535")"
    nmap -sS -p${NMAP_SCAN_PORTSF_FROM} -T5 $1 -oG $NMAP_DIR_NAME/grep_open_port_scanner > /dev/null &
    # wait for this process only to get done 
    wait $!
}

function grep_open_ports() {
    
    nmap_port_scanner $1 
    
    if [ -e $NMAP_DIR_NAME/$PORTS_FILE ]
    then
        OPEN_PORTS=$(cat $NMAP_DIR_NAME/$PORTS_FILE | grep -Eo "[0-9]+/open" | grep -Eo "[0-9]+" | sed -z 's/\n/,/g;s/,$/\n/') 
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
        nmap -sT -p${OPEN_PORTS} -T4 -A -sV -O $1 -oN $NMAP_DIR_NAME/$NMAP_FULL_SCAN_RESULT >/dev/null &
        wait
    else 
        echo "[-] NOT ABLE TO EXTRACT PORTS"
    fi
}