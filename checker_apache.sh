#!/bin/bash
### Variable ###
# Comand #
ECHO="$(which echo) -e"
TIME="date +%F_%T"
# Main #
DIR=$(pwd)
# User vars #
USER_VAR="$DIR/users.var.cfg"
source $USER_VAR
###
send_mail () {
    LOG=$1
    for MAIL in $MAIL_LIST
    do
        cat $LOG | mail -s "$($TIME) apache restart in $(hostname)" $MAIL
    done
    find $DIR -type f -name "*.log" -mtype +2 -exec rm '{}' \; 2>/dev/null
}
apache_start () {
    LOG=$1
    if [[ -n $(systemctl status apache2.service | grep active) ]]
    then
        systemctl start apache2.service \
        && $ECHO "Apache start in $($TIME)\n==========\n" >> $LOG \
        || $ECHO "ALARM! Apache not started in $($TIME)\n==========\n" >> $LOG 
    fi
    send_mail "$LOG"
}
apache_stop () {
    LOG=$1
    $ECHO "netstat result:\n" >> $LOG
    netstat -ne | grep ":80\|:443" >> $LOG
    $ECHO "-----------\napache processes:\n" >> $LOG
    ps aux | grep apache2 | grep -v grep >> $LOG
    for ID in $( ps aux | grep apache2 | grep -v grep | awk '{print$2}' )
    do
        kill -9 $ID 2>/dev/null
    done
    apache_start "$LOG"
}
check_apache () {
    if [[ -z $(curl -I $HOST | grep "200\|301") ]] 
    then
        LOG="$($TIME)_apache_mon.log"
        $ECHO "$($TIME) - $HOST not available\n---------------" >> $LOG
        apache_stop "$LOG"
    fi
}
while :; do
    check_apache
    sleep 5
done
