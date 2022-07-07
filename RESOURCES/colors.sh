#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN="\033[1;36m"

NC='\033[0m' # No Color

function red {
    printf "${RED}$@${NC}\n"
}

function cyan {
    printf "${CYAN}$@${NC}\n"
}

function green {
    printf "${GREEN}$@${NC}\n"
}

function yellow {
    printf "${YELLOW}$@${NC}\n"
}