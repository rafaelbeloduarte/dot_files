# Use "cvt 1920 1080 60" to calculate VESA CVT mode lines
# xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# xrandr --addmode Virtual1 1920x1080_60.00
# xrandr -s 1920x1080
# Para resolver problema com carregamento lento de programas
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
xrdb ~/.Xresources
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
numlockx &
xset s off -dpms &
setxkbmap -layout br
nitrogen --set-zoom-fill --random ~/.local/share/backgrounds/purple &
picom &
/usr/lib/geoclue-2.0/demos/agent &
redshift &
lxpolkit &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
slstatus &
# fcitx &
# xclip &

exec dwm

# iniciar gnome
# export XDG_SESSION_TYPE=x11
# export GDK_BACKEND=x11
# exec gnome-session
