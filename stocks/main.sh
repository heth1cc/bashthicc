#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"

RED=$(tput setaf 1)
GRN=$(tput setaf 2)
YEL=$(tput setaf 3)
RES=$(tput sgr0)

# exit cleanly
trap ctrl_c INT

function ctrl_c() {
    clear
    tput cnorm
    exit
}

Refresh(){
    json=$(curl 'https://api.iextrading.com/1.0/stock/market/batch?symbols=mu,amd&types=price,ohlc&last=1' -s)
    
    for key in $(jq 'keys[]' <<<$json); do
        key=$(tr -d '"' <<<$key)
        close=$(jq ".${key}.ohlc.close.price" <<<$json)
        price=$(jq ".${key}| .price" <<<$json)
        #% change
        change=$(bc <<<"scale=4;($price/$close-1)*100")
        #scale prices
        change=$(bc <<<"scale=2;$change/1")
        price=$(bc <<<"scale=2;$price/1")
        
        if [ $(bc <<<"$change > 0") ]; then
            dir=$GRN    
        elif [ $(bc <<<"$change < 0") ]; then
            dir=$RED
        else
            dir=$RES
        fi

        echo $key $YEL$price'$'$RES $dir$change%$RES
    done

    tput cup 0 0
}

tput civis
clear
while sleep 1;do
    Refresh
done


