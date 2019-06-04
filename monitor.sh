#! /bin/bash

CURRENCY=$1
THRESHOLD=$2

while true
do
    is_below="0"
    if [ "${CURRENCY}" == "XMR" ]; then
        hr=$( grep "Totals (ALL):" /home/profant/xmr-stak/build/bin/log.txt | tac | head -1 | awk '{ print $3 }' )
        hr=$( echo "$hr/1" | bc )
        #echo "Current hashrate $hr."
        is_below=$( echo "$hr < $THRESHOLD" | bc -l | tr -d '\n')
    fi
    if [ "${CURRENCY}" ==  "ETH" ]; then
        cd /home/profant/PhoenixMiner_3.5a_Linux
        logfile=$( ls -l -t | head -2 | tail -1 | awk '{ print $9 }' )
        hr=$(grep "Eth speed:" $logfile | awk '{ print $5 }' | tail -1)
        is_zero=$(echo "$hr > -1 && $hr < 1" | bc -l | tr -d '\n')
        if [ "$is_zero" == "1" ]; then
            echo "${CURRENCY} Hashrate detected as close to zero: $hr"
        else
            is_below=$(echo "$hr < $THRESHOLD" | bc -l | tr -d '\n')
            if [ "$is_below" == "1" ]; then
                sleep 30
                hr=$(grep "Eth speed:" $logfile | awk '{ print $5 }' | tail -1)
                is_below=$(echo "$hr < $THRESHOLD" | bc -l | tr -d '\n')
            fi
        fi
    fi
    if [ "$is_below" == "1" ]; then
        date
        echo "${CURRENCY} Hashrate $hr smaller than threshold. PC will restart in 60 seconds."
        sleep 30
        /home/profant/reboot.sh > /dev/null 2>&1
    else
        echo -n ""
        # date
        # echo "${CURRENCY} Hashrate $hr OK"
    fi
    sleep 35
done 2>&1 | tee -a /home/profant/monitor.log
