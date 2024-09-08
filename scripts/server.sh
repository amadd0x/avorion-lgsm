#!/usr/bin/env bash

avserver=/home/avserver/avserver

first-install() {
  curl -Lo linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh
  ./linuxgsm.sh avserver
  $avserver auto-install
}

if [ ! -f /home/avserver/avserver ]; then
  first-install
fi

case $1 in
  start)
    $avserver update
    $avserver start
    $avserver details
    tail -f /dev/null
    ;;
  *)
    echo "Usage: $0 {start}"
    exit 1
    ;;
esac