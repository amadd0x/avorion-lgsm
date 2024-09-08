#!/usr/bin/env bash
exit_handler () {

        # Execute the  shutdown commands
        su-exec avserver /home/avserver/avserver stop
        exit
}

trap exit_handler SIGTERM

# Set user and group ID to avserver user
groupmod -o -g "1000" avserver  > /dev/null 2>&1
usermod -o -u "1000" avserver  > /dev/null 2>&1
chown -R avserver:avserver /home/avserver

# Change user to avserver
su-exec avserver bash /home/avserver/server.sh start &
wait $!