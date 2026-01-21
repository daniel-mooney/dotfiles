# Starshiprc
Configuration for the starship terminal extension. Tested with Alacritty terminal and a bash shell.

## Installation
Run this command:
```bash
curl -sS https://starship.rs/install.sh | sh
```

Add the following to your `.bashrc` file (or equivalent) to define the location of the `.config` directory in accordance with the XDG directory specification:
```bash
export $XDG_CONFIG_HOME="$HOME/.config"
```
Then, add the following lines to your `.bashrc` (or equivalent) to initialise starship:
```bash
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init bash)"
```
> **Note:** Ensure that `$XDG_CONFIG_HOME` is defined before you initialise starship.

For more information see the [starship website](https://starship.rs/).
