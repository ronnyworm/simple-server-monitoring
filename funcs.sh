#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

send_mail(){
    ruby "$SCRIPT_DIR/send_mail.rb" "$1"
}

website_running(){
    name=$1
    url=$2
    if [[ -z $url ]]; then 
        url=$1
    fi

    result=$(curl -I https://$url 2> /dev/null | head -n 1 | grep -e "200" -e "401" -e "301" -e "302" )
    if [[ -z $result ]]; then
        printf "$name FAILED TO CONNECT\n"
        send_mail "$name FAILED TO CONNECT"
    else
        printf "$name\n  $result\n"
    fi
    sleep 3
}

disk_usage_percent(){
    if [ -z "$1" ]; then
        printf "first parameter must be full disk name e.g. /boot"
        return -1
    fi

    # many spaces -> one
    # column 6
    # linenumber of line containing root
    # just the line number, not the match
    line=$(df -h | tr -s ' ' | cut -f6 -d \ | grep -n "^${1}$" | cut -d : -f1)

    # take the value from column 5 in $line without %
    usage=$(df -h | tr -s ' ' | cut -f5 -d \ | sed -n -e ${line}p | cut -d % -f1)

    echo $usage
}

metric_check(){
    name="$1"
    test_command="$2"
    test_type=$3
    limit=$4
    mail_text="$5"

    number=$(eval $test_command)
    if [ $number $test_type $limit ]; then
        send_mail "$mail_text $limit ($number)"
    fi
    echo "$(date +"%Y-%m-%d %H:%M:%S"),$name,$number,$limit" >> "$SCRIPT_DIR/stats.csv"
}

application_status_check(){
    test_command="$1"
    running_output="$2"
    start_command="$3"
    failure_mail_text="$4"

    output=$(eval $test_command)
    if ! echo "$output" | grep -q "$running_output"; then
        $start_command
        sleep 10
        output=$(eval $test_command)
        if ! echo "$output" | grep -q "$running_output"; then
            send_mail "$failure_mail_text - attempted to start WITH NO SUCCESS"
        else
            send_mail "$failure_mail_text - started it again successfully"
        fi
    else
        echo "$test_command" good
    fi
}
