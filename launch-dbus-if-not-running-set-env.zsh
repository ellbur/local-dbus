#!/bin/zsh

here="$(dirname $0)"
run_dir=$HOME/.local/var/my-dbus

mkdir -p $run_dir

run_file=$run_dir/env

function do-launch {
    $here/kill-running-dbus.zsh
    echo 'Launching dbus'
    . $here/launch-dbus-set-env.zsh 3> $run_file
    echo "$run_file now contains:"
    cat $run_file
}

if [ -e $run_file ] ; then
    echo "$run_file exists"
    . $run_file
    if [[ "$DBUS_SESSION_BUS_PID" == "" ]] ; then
        echo "DBUS_SESSION_BUS_PID not set"
        do-launch
    else
        cmd_file="/proc/$DBUS_SESSION_BUS_PID/cmdline"
        if [ -e $cmd_file ] ; then
            cmdline="$(cat $cmd_file)" 
            echo "cmdline=$cmdline"
            if [[ $cmdline == /usr/bin/dbus-daemon* ]] ; then
                echo 'dbus running -- good'
            else
                echo "PID is not dbus"
                do-launch
            fi
        else
            echo "PID is not running"
            do-launch
        fi
    fi
else
    echo "$run_file does not exist"
    do-launch
fi

