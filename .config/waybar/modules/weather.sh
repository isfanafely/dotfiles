#!/bin/sh
get_icon() {
    case $1 in
        # Icons for weather-icons
        01d) icon=" ";;
        01n) icon="󰖔 ";;
        02d) icon="󰖕 ";;
        02n) icon=" ";;
        03d) icon=" ";;
        03n) icon=" ";;
        04d) icon=" ";;
        04n) icon=" ";;
        09d) icon=" ";;
        09n) icon=" ";;
        10d) icon=" ";;
        10n) icon=" ";;
        11d) icon=" ";;
        11n) icon=" ";;
        13d) icon=" ";;
        13n) icon=" ";;
        50d) icon=" ";;
        50n) icon=" ";;
        *) icon="󰖝 ";
    esac

    echo $icon
}
## Weather data
KEY="662d0878e4211d2bed06315d63416aa0"
LAT="-6.677363"
LON="110.917645"
UNIT="metric"	# Available options : 'metric' or 'imperial'
SYMBOL="°C"

weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$KEY&units=$UNIT")
weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
echo "$(get_icon "$weather_icon") ""$weather_temp$SYMBOL"

