SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rm -rf ~/.config/starship
ln -s "$SCRIPT_DIR" ~/.config/starship
