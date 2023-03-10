#!/bin/sh
get_icon() {
    case $1 in
        # Icons for weather-icons
        01) icon="󱑋 ";;
        02) icon="󱑌 ";;
        03) icon="󱑍 ";;
        04) icon="󱑎 ";;
        05) icon="󱑏 ";;
        06) icon="󱑐 ";;
        07) icon="󱑑 ";;
        08) icon="󱑒 ";;
        09) icon="󱑓 ";;
        10) icon="󱑔 ";;
        11) icon="󱑕 ";;
        12) icon="󱑖";;
    esac

    echo $icon
}

clock_icon=$(echo "$(date +'%I')")
echo "$(get_icon "$clock_icon") "