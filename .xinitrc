#!/bin/sh
#parcellite &
sh /home/dexter4/.fehbg &
#xcompmgr -c &
#sudo wicd-gtk &
#wicd-curses rocks =)
#xterm -T WICD -e sudo wicd-curses &
#conky -c /home/dexter4/.conkyrc-console |dzen2 -ta left &
#hologate the xterm fonts to dzen2 and ok :)
#emm suggestion of 4chan /g/ people :)
#conky -c /home/dexter4/.conkyrc-console |dzen2 -ta left -fg '#ddccbb' -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' &
#conky -c  $HOME/.conkyrc-console |dzen2 -ta left -fg '#ddccbb' -fn '-*-terminus-*-r-normal-*-*-90-*-*-*-*-iso8859-*' &
xbindkeys &
autocutsel &
setxkbmap es &
#perl /home/dexter4/wifisignalxd.pl &
#bash /home/dexter4/wifistatusbar2xx2 wlan1 &
compton -m 0.75 -b &
#wmwave &
#wmload -shape -u 2 -exe ksysguard &
#xsetroot -cursor_name left_ptr &
#exec 9wm -nostalgia -virtuals 14
#exec /usr/local/bin/ratpoison
#conky -c /home/dexter4/.conkyrc-console | while read -r; do xsetroot -name "$REPLY"; done &
#perl /home/dexter4/wifisignal.pl &
#bash /home/dexter4/wifistatusbar2xx wlan0 &
#bash /home/dexter4/wifistatusbar2xx wlan0 |dzen2 &
#sh $HOME/.console_conky
#exec /usr/local/bin/dwm
#exec ctwm
#exec w9wm -nostalgia -virtuals 14
#exec smallwm
#exec twm
#xcompmgr not render shadows
#compton -c -m 0.75 -b &
#compton -m 0.75 -b &
#exec /usr/local/bin/karmen
#exec /usr/local/bin/novawm
#exec tvtwm
#exec vtwm
#xclock -name myclock -bg black -fg white -digital -geometry 300x25-1-1 -fn "-*-charter-*-*-*-*-*-140-*-*-*-*-*-*" &
#xclock -name myclock -bg black -fg white -digital -geometry 300x25-1-731 -fn "-*-charter-*-*-*-*-*-140-*-*-*-*-*-*" &
#exec twm
#exec x9wm -nostalgia -virtuals 14
#exec lwm
#exec ctwm
#exec /usr/local/bin/dwm
#exec /usr/local/bin/wmaker
#exec /usr/local/bin/ratpoison
#exec vtwm
#exec bash /home/dexter4/wifistatusbar2xx wlan1 |dzen2 -ta right -fg '#c3c2c5' -fn 
#'-*-terminus-*-r-normal-*-*-90-*-*-*-*-iso8859-*' &
exec bash /home/dexter4/wifistatusbar2xx wlan1 |dzen2 -x 0 -y 1038 -ta right -fg '#c3c2c5' -fn '-*-terminus-*-r-normal-*-*-90-*-*-*-*-iso8859-*' &
#exec bash /home/dexter4/wifistatusbar2xx wlan0 |dzen2 -ta right -fg '#c3c2c5' -fn '-*-lucida-*-*-*-sans-10-*-*-*-*-*-*-*' &
#bash /home/dexter4/wifistatusbar2xx wlan1 |dzen2 -ta right -fg '#c3c2c5' -fn '-*-dejavu sans-*-*-normal-*-9-*-*-*-*-*-*-*' &
#exec 9wm -nostalgia -term xterm
#exec startkde
#exec openbox
#exec openbox-kde-session
#exec vtwm
#/usr/local/bin/compiz --indirect-rendering --keep-desktop-hints --loose-binding --sm-disable gconf
#while true; do
    # Log stderror to a file
    #dwm 2> ~/.dwm.log
    # No error logging
#    /usr/local/bin/dwm >/dev/null 2>&1
#    /usr/bin/catwm >/dev/null 2>&1
#done
#/usr/local/bin/dwm
exec /usr/local/bin/catwm
