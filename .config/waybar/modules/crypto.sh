#!/bin/bash

bitcoin_price=$(curl -sf  https://api.coindesk.com/v1/bpi/currentprice.json | jq -r ".bpi.USD.rate"| cut -d "." -f 1)

echo "$"$bitcoin_price