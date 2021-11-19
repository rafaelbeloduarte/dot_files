xrandr --newmode "1920x1000_60.00"  159.25  1920 2040 2240 2560  1000 1003 1013 1038 -hsync +vsync
xrandr --addmode Virtual1 1920x1000_60.00
xrandr -s 1920x1000_60.00
numlockx &
setxkbmap -layout br &
slstatus &
nitrogen --restore &

exec dwm
