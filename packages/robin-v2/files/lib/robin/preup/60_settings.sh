#!/bin/sh 

MODE="0"
WDIR=/etc/update 
SETTINGS="mesh wireless general iprules management node olsr radio cp_switch"

[ -h /usr/sbin/update-wireless.sh ] || ln -sf /usr/sbin/update-wifi.sh /usr/sbin/update-wireless.sh

for f in $SETTINGS ; do
	[ -e $WDIR/$f ] && /usr/sbin/update-${f}.sh $MODE
done

case $(uci get cp_switch.main.which_handler) in
	1) [ -e $WDIR/nodog ] &&	/usr/sbin/update-nodog.sh $MODE ;;
	4|5|6) [ -e $WDIR/chilli ] &&	/usr/sbin/update-chilli.sh $MODE ;;
esac

sync
#
