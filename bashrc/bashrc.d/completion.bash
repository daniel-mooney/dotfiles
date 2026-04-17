[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
__lazy_load_bash_completion() {
	# System completions
	if ! shopt -oq posix; then
		if [ -f /usr/share/bash-completion/bash_completion ]; then
			. /usr/share/bash-completion/bash_completion
		elif [ -f /etc/bash_completion ]; then
			. /etc/bash_completion
		fi
	fi

	# Custom completions
	eval "$(uv generate-shell-completion bash)"
	eval "$(pixi completion --shell bash)"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

complete -D -F __lazy_load_bash_completion
