#!/bin/bash

hour=$(date +%H)
dark="/home/william/Pictures/tiles/dark/"
light="/home/william/Pictures/tiles/light/"

while true; do
		if [[ $hour -ge 18 ]]; then
				cd $dark
		else
				cd $light
		fi
		feh --bg-tile "$(ls | shuf -n1)"
		sleep 3600
done
