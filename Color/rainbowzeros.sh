#!/bin/bash
# Try all strings! Should work for 8/16 colors
# By thyme

funwheel () {
	count=0
	not=1
#	while (( "$count" -ne "$not" ))i
	for i in {0..3000}
	do
		#grayscale is 231-255
				#color=`seq 200 255 | head -n 1`
				color=$((RANDOM%255))
				move=$((RANDOM%6))
				for i in ${move}
				do
					echo -en "\e[8;38;5;${color}m0\e[0m"
			done
done
}

funwheel
funwheel
funwheel
