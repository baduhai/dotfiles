#!/bin/sh

perc=$(acpi | cut -f4 -d' ' | tr -d '%,')
state=$(acpi | cut -f3 -d' ')
case $state in
    Discharging,) STATE="-" ;break;;
    Charging,) STATE="+" ;break;;
    *) STATE="?";break;;
esac

PERC="$perc%%"
TIME=$(acpi | cut -f5 -d' '| grep -E -o ".....")

                    if (($perc <= 10)) ; then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue242")"
                    elif (($perc <= 20)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue243")"
                    elif (($perc <= 30)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue244")"
                    elif (($perc <= 40)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue245")"
                    elif (($perc <= 50)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue246")"
                    elif (($perc <= 60)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue247")"
                    elif (($perc <= 70)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue248")"
                    elif (($perc <= 80)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue249")"
                    elif (($perc <= 90)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue24a")"
                    elif (($perc <= 100)); then
                        LOW_ICON=""
                        PERC_ICON="$(printf "\ue24b")"
                    fi

printf "$PERC_ICON: $PERC $STATE ($TIME)"
