#!/bin/bash

hour=$(date +%H)
dark="/home/william/Pictures/tiles/dark/"
light="/home/william/Pictures/tiles/light/"

while true; do
		if [[ $hour -ge 17 ]]; then
				cd $dark
		else
				cd $light
		fi
		feh --bg-tile "$(ls | shuf -n1)"
		sleep 1800
done
