#!/bin/bash
#
# score_oom.sh
# Copyright (C) 2014 crozz <crozz@segv.sx>
#
# Distributed under terms of the GPLv3 license.
#


MaxScore=0
Process=0

for PID in $(ps --no-headers -eo pid); do
	if [ -r /proc/$PID/oom_score ]; then
		Score=$(cat /proc/$PID/oom_score)

		if [ $MaxScore -le $Score ]; then
			Process=$PID
			MaxScore=$Score
		fi
	fi
done

echo "El proceso en lista del OOM Killer es:"
ps -o pid,comm --no-headers $Process