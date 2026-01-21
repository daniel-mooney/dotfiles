SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rm -rf ~/.config/nvim
ln -s "$SCRIPT_DIR" ~/.config/nvim
