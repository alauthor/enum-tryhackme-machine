#!/bin/bash 

FIRST_LINES_FROM_WORDLIST_TO_SCAN=5000
SCAN_DIRECTORY_FOR="php,txt,html,sql,db,bak"
HTTP_DEFAULT_PORT=80

function directory_traverse(){
    if [ -e /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt ]
    then
        head -n $FIRST_LINES_FROM_WORDLIST_TO_SCAN /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt | gobuster dir -u "http://${1}:${HTTP_DEFAULT_PORT}/" -w - -x $SCAN_DIRECTORY_FOR -T 50 -o SCAN/TRAVERSING/gobuster_result_scan.txt > /dev/null &
    else 
        echo -e "[-] FILE $(red directory-list-2.3-medium.txt) DOESN'T EXIST"
        exit 1
    fi
}

function nikto_scan() {
    nikto -h "http://${1}:${HTTP_DEFAULT_PORT}/" -output SCAN/NIKTO/result.txt > /dev/null &
}

function is_http_port_open() {
    #START PORT 80 SCANNING .
    nmap -sS -p${HTTP_DEFAULT_PORT} $1 -oN SCAN/NMAP/nmap-port-80-scan.nmap > /dev/null &
    wait
}


function http_spider() { 
   wget -nd -r -P output -A jpeg,jpg,bmp,gif,png,sql,db,txt,bak http://${1}:${HTTP_DEFAULT_PORT}/
   wait
}