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


# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   git 
#   aws
#   docker
#   command_execution_time
#   direnv
#   disk_usage
#   ram
#   kube_context
#   vcs
#   zsh-syntax-highlighting
#   zsh-autosuggestions
# )


export LANG=en_US.UTF-8
export EDITOR=nvim


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
export PYENV_VERSION=3.13
eval "$(direnv hook zsh)"



export DOTFILES_ROOT="$HOME/code/personal/dotfiles"
export CN_DOTFILES_ROOT="$HOME/code/personal/cn-dotfiles"

export PATH="$DOTFILES_ROOT/bin:$PATH"
export PATH="$CN_DOTFILES_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# should not be version controlled
source $HOME/.secrets
source $HOME/.aliases
source $CN_DOTFILES_ROOT/.cn_aliases



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