#!/bin/sh
a="$(ps -eaf | grep "update_Devices_based_on_DB.py" | grep -v "grep" | awk '{print $2}')"
b="$(ps -eaf | grep "espSignalCheck.py" | grep -v "grep" | awk '{print $2}')"
c="$(ps -eaf | grep "RPiAlexa.py" | grep -v "grep" | awk '{print $2}')"
d="$(ps -eaf | grep "MAC_2_IP_MAP_Regular.py" | grep -v "grep" | awk '{print $2}')"
e="$(ps -eaf | grep "client_ask_server.py" | grep -v "grep" | awk '{print $2}')"
f="$(ps -eaf | grep "requestPort.py" | grep -v "grep" | awk '{print $2}')"
g="$(ps -eaf | grep "AutoDoorLock.py" | grep -v "grep" | awk '{print $2}')"
#h="$(ps -eaf | grep "server_for_clients_v1.py" | grep -v "grep" | awk '{print $2}')"

if [ -z "$a" ]; then
	echo "update_Devices_based_on_DB.py was NOT Running"
	python /skanth/sqlscripts/update_Devices_based_on_DB.py &
fi
if [ -z "$b" ]; then
	echo "espSignalCheck.py was NOT Running"
	python /skanth/sqlscripts/espSignalCheck.py &
fi
if [ -z "$c" ]; then
	echo "RPiAlexa.py was NOT Running"
	python3 /skanth/sqlscripts/AlexaConf/RPiAlexa.py &
fi
if [ -z "$d" ]; then
	echo "MAC_2_IP_MAP_Regular.py was NOT Running"
        python /skanth/sqlscripts/MAC_2_IP_MAP_Regular.py DW &
fi
if [ -z "$e" ]; then
	echo "client_ask_server.py was NOT Running"
	if [ ! -z "$f" ]; then
		echo "But requestPort.py was running... Killed"
		kill -9 $f
		sleep .1
	fi
	python /skanth/sqlscripts/requestPort.py &
fi

if [ -z "$g" ]; then
        echo "AutoDoorLock.py was NOT Running"
        python /skanth/sqlscripts/AutoDoorLock.py &
fi

#if [ -z "$h" ]; then
#        echo "AutoDoorLock.py was NOT Running"
#	echo "Process Started" >> /skanth/sqlscripts/TCP_TEST/Restarts
#        python /skanth/sqlscripts/TCP_TEST/server_for_clients_v1.py 8008 &
#fi
