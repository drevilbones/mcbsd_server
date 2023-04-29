#!/bin/bash

mc_comp=`pwd`
mc_data="/opt/minecraft/data/"
mc_backup="/big/Archives/mc_backups"
maxbackups=30

mc_send () {  echo "$1" | socat EXEC:"docker attach mcbds",pty STDIN; }

mc_send "say §6Server going down for backups in §415 minutes!"
sleep 5m
mc_send "say §6Server going down for backups in §410 minutes!"
sleep 5m
mc_send "say §6Server going down for backups in §45 minutes!"
sleep 5m
mc_send "say §6Server going down for backups §4right now! Byebye!"
sleep 5

mc_send "stop"

sleep 10

cd $mc_data
fname="mc_$(date +%s).tgz"
tar czvf $fname worlds
cd $mc_comp
docker compose up -d
mv $mc_data/$fname $mc_backup

cd $mc_backup
numbackups=$(ls | wc -l)
if [[ numbackups -gt maxbackups ]]
then
	ls -1t | tail -n 1 | xargs rm -f
fi

