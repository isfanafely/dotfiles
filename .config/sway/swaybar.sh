#!/bin/sh

## program state
#

previous_network_time=$(date "+%s.%N")
previous_network_tx_bytes=$(cat /sys/class/net/enp5s0/statistics/tx_bytes)
previous_network_rx_bytes=$(cat /sys/class/net/enp5s0/statistics/rx_bytes)



## header
#
# man -s7 swaybar-protocol
#
echo '{ "version": 1 }'
echo -n '['


while /bin/true; do

	## date
	#
	# Input:
	#   Wed Oct 26 01:33:28 PM PDT 2022
	#
	# Output:
	#   Wed Oct 26 13:33
	date_formatted="$(date "+%a %b %d %H:%M %p")"

	## cput temperature
	#
	# Input:
	#   25700
	#
	# Output:
	#   25.7 C
	#
	temperature_value=$(cat /sys/class/hwmon/hwmon2/temp1_input)
	temperature_celcius=$(echo "$temperature_value/1000" | bc -l)
	temperature_formatted=$(printf "\udb83\udee0  %0.1f °C" $temperature_celcius)

	## memory
	#
	# Input:
	#                  total        used        free      shared  buff/cache   available
	#   Mem:              31           2          24           0           4          27
	#   Swap:              7           0           7
	#
	# Output:
	#   T: 31 Gb U: 2 Gb F: 24 Gb
	memory_total=$(free -g | grep "Mem" | awk '{ print $2 }')
	memory_used=$(free -g | grep "Mem" | awk '{ print $3 }') 
	memory_free=$(free -g | grep "Mem" | awk '{ print $4 }')
	
	memory_formatted=$(printf "U: %d F: %d (Gb)" $memory_used $memory_free)

	## network stats
	#
	network_time=$(date "+%s.%N")
	network_tx_bytes=$(cat /sys/class/net/enp5s0/statistics/tx_bytes)
	network_rx_bytes=$(cat /sys/class/net/enp5s0/statistics/rx_bytes)

	network_tx_mbps=$(echo "($network_tx_bytes-$previous_network_tx_bytes)/($network_time-$previous_network_time)*8/1000000" | bc -l)
	network_rx_mbps=$(echo "($network_rx_bytes-$previous_network_rx_bytes)/($network_time-$previous_network_time)*8/1000000" | bc -l)

	## network info
	#
	network_ip_address=$(ip address | grep "enp5s0" | grep "inet" | awk '{ print $2 }')
	
	previous_network_time=$network_time
	previous_network_tx_bytes=$network_tx_bytes
	previous_network_rx_bytes=$network_rx_bytes

	network_formatted=$(printf "⬇ %0.2f  ⬆ %0.2f (Mb/s)" $network_rx_mbps $network_tx_mbps)
	#space
	space1=$(printf " ")
	#space2=$(printf "")
	
	# generate the output for swaybar
	echo "[ { 'full_text': ' $space1' },{ 'full_text': ' $network_formatted ' },{ 'full_text': ' $memory_formatted ' },{ 'full_text': ' $temperature_formatted ' },{ 'full_text': ' $date_formatted ' } ],"

	sleep 1
done
