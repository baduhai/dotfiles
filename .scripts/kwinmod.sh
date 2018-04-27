#! /bin/bash

sleep 5
sed '97c\BorderlessMaximizedWindows=true' -i ~/.config/kwinrc
kwin_x11 --replace
