me="`basename $0`"

# find udev.conf, often /etc/udev/udev.conf
# (or environment can specify where to find udev.conf)
#
echo "\033[32m**MM finding udev rules directory..."
if test -z "$conf"; then
	if test -r /etc/udev/udev.conf; then
		conf=/etc/udev/udev.conf
	else
		conf="`find /etc -type f -name udev.conf 2> /dev/null`"
		if test -z "$conf" || test ! -r "$conf"; then
			echo "\033[31m**EE $me Error: no udev.conf found" 1>&2
			exit 1
		fi
	fi
fi

# find the directory where udev rules are stored, often
# /etc/udev/rules.d
#
rules_d="`sed -n '/^udev_rules=/{ s!udev_rules=!!; s!\"!!g; p; }' $conf`"
if test -z "$rules_d" ; then
	rules_d=/etc/udev/rules.d
fi
if test ! -d "$rules_d"; then
	echo "\033[31m**EE $me Error: cannot find udev rules directory" 1>&2
	exit 1
fi

rules_d_stm32_in_dfu=$rules_d/40-stm32_in_dfu.rules

echo "\033[34m**II Installing stm32_dfu rules on $rules_d_stm32_in_dfu"

(
cat <<'EOF'
ACTION!="add|change", GOTO="stm32_in_dfu_rules_end"
SUBSYSTEM!="usb", GOTO="stm32_in_dfu_rules_end"
ENV{DEVTYPE}!="usb_device", GOTO="stm32_in_dfu_rules_end"

# Section5 ICEbear
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="664", GROUP="plugdev"

LABEL="stm32_in_dfu_rules_end"
EOF
) > $rules_d_stm32_in_dfu

if [ -f $rules_d_stm32_in_dfu ]
then
	echo "\033[32m"
	echo "**II stm32 dfu udev rules installed."
	echo "**II Ensure if $USER have in plugdev group and reconnect your STM32_CL target"
else
	echo "\033[31m"
	echo "**EE Can't install $rules_d_stm32_in_dfu."
	echo "**EE Ensure if your user have permision to write in $rules_d directory"
fi
