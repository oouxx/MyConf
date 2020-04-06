setxkbmap -option altwin:swap_lalt_lwin
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_CTYPE=zh_CN.UTF-8
libinput-gestures &
fcitx &
dunst &
/usr/lib/gsd-xsettings > /dev/null 2>&1 &
# mpd /home/wxx/.config/mpd/mpd.conf &
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec i3
