#!/bin/zsh

echo 'Killing any running dbus'

pid_lines="$(ps -F -C dbus-daemon | grep syslog | awk '{print $2}')"
pids=("${(@f)pid_lines}")

for pid in $pids ; do
    echo "Killing $pid"
    kill $pid
done

