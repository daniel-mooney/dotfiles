SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rm -rf ~/.bashrc
ln -s $SCRIPT_DIR/bashrc ~/.bashrc
