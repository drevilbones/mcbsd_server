#!/bin/bash

maxbackups=30

mc_send () {  echo "$1" | socat EXEC:"docker attach minecraft-bds-1",pty STDIN; }

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

cd /home/nick/minecraft/data
fname="mc_$(date +%s).tgz"
tar czvf $fname worlds
cd /home/nick/minecraft
docker compose up -d
mv data/$fname /big/Archives/mc_backups

cd /big/Archives/mc_backups
numbackups=$(ls | wc -l)
if [[ numbackups -gt maxbackups ]]
then
	ls -1t | tail -n 1 | xargs rm -f
fi

