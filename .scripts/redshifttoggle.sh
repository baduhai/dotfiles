#!/bin/bash

if pgrep -x "redshift" > /dev/null
then
	killall redshift
else
	redshift &
fi