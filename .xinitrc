# xrandr --newmode "1920x1000_60.00"  159.25  1920 2040 2240 2560  1000 1003 1013 1038 -hsync +vsync
# xrandr --addmode Virtual1 1920x1000_60.00
# xrandr -s 1920x1080
numlockx &
xset s off -dpms &
setxkbmap -layout br
nitrogen --set-zoom-fill --random ~/.local/share/backgrounds/ &
picom &
/usr/lib/geoclue-2.0/demos/agent &
redshift &
lxpolkit &
# /usr/lib/xfce4/notifyd/xfce4-notifyd &
# slstatus &
volumeicon &

exec awesome
