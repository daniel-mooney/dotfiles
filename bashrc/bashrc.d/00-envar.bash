# Custom Environment Variables
export VISUAL=nvim
export EDITOR=nvim

# Need additional bat flags to fix broken color parsing and ^H bug
# col is a text formatter
export MANPAGER='sh -c "col -bx | batcat -l man -p"'
export MANROFFOPT='-c' 

# XDG Base Directory Spec
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
