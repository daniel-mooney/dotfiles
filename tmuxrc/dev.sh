SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rm -rf ~/.config/tmux
ln -s "$SCRIPT_DIR" ~/.config/tmux
