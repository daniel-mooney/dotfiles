SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rm -rf ~/.config/yazi
ln -s "$SCRIPT_DIR" ~/.config/yazi
