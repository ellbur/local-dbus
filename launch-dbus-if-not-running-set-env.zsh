#!/bin/zsh

here="$(dirname $0)"
run_dir=$HOME/.local/var/my-dbus

mkdir -p $run_dir

run_file=$run_dir/env

if [ -e $run_file ] ; then
    echo "$run_file exists"
    . $run_file
    if ps $DBUS_SESSION_BUS_PID ; then
        echo 'dbus running -- good'
    else
        echo 'Launching dbus'
        . $here/launch-dbus-set-env.zsh 3> $run_file
    fi
else
    echo "$run_file does not exist"
    echo 'Launching dbus'
    . $here/launch-dbus-set-env.zsh 3> $run_file
fi

