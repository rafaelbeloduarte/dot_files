# Use "cvt 1920 1080 60" to calculate VESA CVT mode lines
# xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# xrandr --addmode Virtual1 1920x1080_60.00
# xrandr -s 1920x1080
# Para resolver problema com carregamento lento de programas
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
numlockx &
xset s off -dpms &
setxkbmap -layout br
nitrogen --set-zoom-fill --random ~/.local/share/backgrounds/ &
picom &
/usr/lib/geoclue-2.0/demos/agent &
redshift &
lxpolkit &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xfce4-clipman &
slstatus &
xbindkeys &
# volumeicon &

exec dwm
