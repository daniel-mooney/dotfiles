SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rm -rf ~/.config/alacritty
ln -s "$SCRIPT_DIR" ~/.config/alacritty
