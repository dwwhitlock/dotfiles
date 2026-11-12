export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=~/.local/bin:$PATH

# # Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system (skip full rebuild unless the cache is >24h old)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi




export LANG=en_US.UTF-8
export EDITOR=nvim


## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

## direnv
eval "$(direnv hook zsh)"


## custom dotfiles
export DOTFILES_ROOT="$HOME/code/dotfiles"
export CN_DOTFILES_ROOT="$HOME/code/cn-dotfiles"
export PATH="$DOTFILES_ROOT/bin:$PATH"
export PATH="$CN_DOTFILES_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# also loads ~/.cn_shellrc.local
source $CN_DOTFILES_ROOT/.cn_shellrc



### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/dwightwhitlock/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Java 17 (required for PySpark 4.x)
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$JAVA_HOME/bin:$PATH"

# bun completions
[ -s "/Users/dwightwhitlock/.bun/_bun" ] && source "/Users/dwightwhitlock/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fpath+=~/.zfunc; autoload -Uz compinit; compinit

# zstyle ':completion:*' menu select
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# >>> cn-workstation >>>
source "/Users/dwightwhitlock/code/platform-workstation/shellenv.sh"
# <<< cn-workstation <<<
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
