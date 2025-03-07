# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git 
  aws
  docker
  command_execution_time
  direnv
  disk_usage
  ram
  kube_context
  vcs
  zsh-syntax-highlighting
  zsh-autosuggestions
)


export LANG=en_US.UTF-8
export EDITOR=nvim



# To customize prompt, run `p10k configure` or edit ~/  .p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(direnv hook zsh)"


# should not be version controlled
source $HOME/.secrets


source $HOME/.aliases
export DOTFILES_ROOT="$HOME/dotfiles"
export PATH="$DOTFILES_ROOT/bin:$PATH"



source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/dwightwhitlock/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)


export JAVA_HOME=/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH