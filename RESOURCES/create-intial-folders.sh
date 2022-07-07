#!/bin/bash


function create_directories() {
    
    mkdir -p SCAN/NMAP
    mkdir -p SCAN/NIKTO 2>/dev/null
    mkdir -p SCAN/TRAVERSING 2>/dev/null
    mkdir -p SCAN/WEBSERVER/
    if [ "$?" == "0" ]
    then 
        echo -e "[+] $(green SCAN) FOLDER CREATED SUCCESSFULLY"
    else 
        echo '[-] SCAN FOLDER DID NOT CREATED SUCCESSFULLY, PLEASE RUN THIS AS ROOT'
        exit 0 
    fi 
}