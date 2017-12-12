PATH=$HOME/bin:$PATH
export PATH

PS1="[\$?]\$ "
export PS1

HISTCONTROL=ignoreboth
HISTIGNORE=ls:ll:la:cnl:d:pd:xd
HISTTIMEFORMAT='%F %T '

alias l='ls -rt'
alias ll='ls -lrt'
alias la='ls -Aort'
alias lla='ls -Alort'

alias d='dirs -v'
alias pd=pushd
alias xd=popd

# careful move and copy
alias cmv='mv -i'
alias ccp='cp -i'

alias commando='ulimit -c unlimited'

# pwd
p() {
	echo ${PWD-$(pwd)}
}

# who and where am i?
wami() {
	local h=${HOSTNAME-$(hostname -s)}
	local u=${USER-$(id -n $EUID)}
	local p=${PWD-$(pwd)}
	echo "${u}@${h}${p}"
}

# chdir and list
cnl() {
	if [[ $# -gt 1 ]]; then
		return 1
	fi
	if cd ${1:-${HOME}}; then
		ls -rt
	fi
}

# start in the background and disown
disavow() {
	$* 2>&1 >/dev/null &
	if [[ $? -eq 0 ]]; then
		disown $!
	fi
}

# search and destory process by name
sad() {
	local match
	match=$(pgrep -u $UID -lfi $*)
	if [[ ! -z $match ]]; then
		echo $match
		read -p "Kill with prejudice (yes/NO)? " ans
		case "$ans" in
			yes|Yes|YES) kill -9 ${match%% *};;
		esac
		return 0
	fi
	return 1
}

