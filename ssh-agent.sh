#!/bin/sh
if [ -f ~/.agent.env ]; then
	. ~/.agent.env >/dev/null
	if ! kill -0 $SSH_AGENT_PID >/dev/null 2>&1; then
		echo "Stale agent file found. Spawning new agent..."
		eval `ssh-agent |tee ~/.agent.env`
		ssh-add
		if [ -f ~/.ssh/tpv.mobile ]; then
			ssh-add ~/.ssh/tpv.mobile
		fi
		if [ -f ~/.ssh/martin.cai ]; then
			ssh-add ~/.ssh/martin.cai
		fi
	fi
else
	echo "Starting ssh-agent..."
	eval `ssh-agent |tee ~/.agent.env`
	ssh-add
	if [ -f ~/.ssh/tpv.mobile ]; then
		ssh-add ~/.ssh/tpv.mobile
	fi
	if [ -f ~/.ssh/martin.cai ]; then
		ssh-add ~/.ssh/martin.cai
	fi
fi
