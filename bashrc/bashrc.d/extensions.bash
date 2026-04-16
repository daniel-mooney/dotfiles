source "$HOME/.cargo/env"

export PATH="/home/daniel-mooney/.pixi/bin:$PATH"

# opencode
export PATH=/home/daniel-mooney/.opencode/bin:$PATH

export NVM_DIR="$HOME/.config/nvm"

# Required for copilot.lua to not break
export PATH="$NVM_DIR/versions/node/v24.14.1/bin:$PATH"

_lazy_load_nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

nvm()  { _lazy_load_nvm; nvm  "$@"; }
node() { _lazy_load_nvm; node "$@"; }
npm()  { _lazy_load_nvm; npm  "$@"; }
npx()  { _lazy_load_nvm; npx  "$@"; }

 
# # STM32 Programmer CLI
# export PATH=$PATH:~/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin

source "$HOME/.local/share/../bin/env"
eval "$(zoxide init bash)"
