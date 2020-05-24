#!/bin/bash
add=${ADD:-$1}
port=${PORT:-51200}

[ -n "$add" ] || { echo "add is missing!"; exit 1 ; }

i=0

get-additional-ips | while read ip
do
    id=$(jq -r ".inbounds[0].settings.clients[$i].id" /etc/v2ray/config.json)
    vmess=$(printf "{\"add\": \"$add\", \"aid\": \"64\", \"host\": \"\", \"id\": \"$id\", \"net\": \"tcp\", \"path\": \"\", \"port\": \"$port\", \"ps\": \"$ip\", \"tls\": \"\", \"type\": \"none\", \"v\": \"2\"}")
    echo "vmess://$(printf "$vmess" | base64 -w 0)"

    i=$((i+1))
done
