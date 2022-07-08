#!/bin/bash

function directory_traverse(){
    echo -e "[*] $(yellow 'STARTING DIRECTORY DISCOVERING') USING $(yellow gobuster) TOOL IN BACKGROUND"
    if [ -e $PATH_TO_TRAVERSING_WORDLIST ]
    then
        head -n $FIRST_LINES_FROM_WORDLIST_TO_SCAN $PATH_TO_TRAVERSING_WORDLIST | gobuster -w - dir -u "http://${1}:${HTTP_DEFAULT_PORT}/" -x $SCAN_DIRECTORY_FOR -t 50 -o $TRAVERSING_DIR_NAME/$TRAVERSING_OUTPUT_FILE_NAME 2>/dev/null > /dev/null &
    else 
        echo -e "[-] FILE $(red $(basename $PATH_TO_TRAVERSING_WORDLIST)) DOESN'T EXIST"
        exit 1
    fi
}

function nikto_scan() {
    echo -e "[*] $(yellow 'STARTING NIKTO') SCAN IN BACKGROUND" 
    nikto -h "http://${1}:${HTTP_DEFAULT_PORT}/" -output $NIKTO_DIR_NAME/$NIKTO_OUTPUT_FILE_NAME > /dev/null &
}

function is_http_port_open() {
    echo -e "[*] $(yellow "SEARCHING IF HTTP IS OPEN ON PORT ${HTTP_DEFAULT_PORT}")"
    nmap -sS -p${HTTP_DEFAULT_PORT} $1 -oN $NMAP_DIR_NAME/$NMAP_OUTPUT_PORT_80 > /dev/null &
    wait
}

function http_spider() { 
    echo -e "[*] $(yellow "START SPIDERING WEBSERVER") SEARCING FOR $(yellow STEG) FILES"
    wget -nd -r -P $WEBSERVER_RESOURCES_DIR_NAME -A ${SPIDER_FILES_EXTENSIONS} http://${1}:${HTTP_DEFAULT_PORT}/ 2>/dev/null >/dev/null &
}

function cewl_webserver() {
    echo -e "[*] $(yellow "START GENERATING WEBSERVER WORDLIST USING CEWL")"
    cewl "http://${1}:${HTTP_DEFAULT_PORT}/" -d $CEWL_DEPTH -n -e -m $CEWL_MINUMUM_WORD_LENGHT -w $WEBSERVER_WORDLIST_DIR_NAME/$CEWL_OUTPUT_FILE_NAME >/dev/null &
}