#!/usr/bin/env bash

#/ Usage:
#/   ./explainshell.sh '<command>'
#/
#/ Attention! Please use single quote '' to quote <command>

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
(expr "$1" : "--help" || expr "$1" : "-h") > /dev/null && usage

if [[ -z $(command -v python3) ]]; then
    echo "This script will NOT work on your machine."
    echo "Please install 'python3'"
    exit 1
fi

if [[ -z $(command -v curl) ]]; then
    echo "This script will NOT work on your machine."
    echo "Please install 'curl'"
    exit 1
fi
_CURL=$(command -v curl)

if [[ -z $(command -v hxselect) || -z $(command -v hxnormalize) ]]; then
    echo "This script will NOT work on your machine."
    echo "Please install 'HTML-XML-utils': https://www.w3.org/Tools/HTML-XML-utils/README"
    exit 1
fi
_HXSELECT=$(command -v hxselect)
_HXNORMALIZE=$(command -v hxnormalize)

if [[ -z "$*" ]]; then
    echo "Missing input"
    usage
    exit 1
fi

_CMD=$(python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))" "$@")
_URL="https://explainshell.com/explain?cmd=$_CMD"

echo "URL: $_URL"

result=$($_CURL -sS "$_URL" | $_HXNORMALIZE -x | $_HXSELECT -c '.help-box', '.push' -s '\n' | sed -E 's/<(\/)?[uib]>//g')

python3 -c "import html,sys; print(html.unescape(sys.argv[1]))" "$result"
