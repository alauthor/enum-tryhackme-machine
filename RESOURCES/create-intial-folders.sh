#!/bin/bash


function create_directories() {
    
    mkdir -p $NMAP_DIR_NAME
    mkdir -p $NIKTO_DIR_NAME 2>/dev/null
    mkdir -p $TRAVERSING_DIR_NAME 2>/dev/null
    mkdir -p $WEBSERVER_RESOURCES_DIR_NAME 2>/dev/null
    mkdir -p $WEBSERVER_WORDLIST_DIR_NAME 2>/dev/null
    mkdir -p $WEBSERVER_SEARCHING_FOR_KEYWORDS_DIR_NAME 2>/dev/null
    mkdir $TEMP_KEYWORDS_DIR 2>/dev/null
    
    if [ "$?" == "0" ]
    then 
        echo -e "[+] $(green "SCAN FOLDER CREATED SUCCESSFULLY")"
    else 
        echo "[-] $(red "SCAN FOLDER DID NOT CREATED SUCCESSFULLY, PLEASE RUN THIS AS ROOT")"
        exit 0 
    fi 
}