# Homebrew dependencies for this dotfiles repo.
# Install / update everything:   brew bundle --file=~/code/dotfiles/Brewfile
# See what's missing:            brew bundle check --verbose --file=~/code/dotfiles/Brewfile
#
# Install order of preference (see CLAUDE.md): brew > apt > bun.

tap "databricks/tap"
tap "hashicorp/tap"

# --- Shell (.zshrc, HOTKEYS.md) ---
brew "direnv"
brew "fzf"
brew "neovim"                  # $EDITOR, ^X^E
brew "starship"
brew "bun"                     # JS runtime; completions come via Homebrew's site-functions
brew "zoxide"                  # z / zi, bin/zseed
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# --- Git (git/config) ---
brew "gnupg"                   # commit/tag signing; gpg.program = /opt/homebrew/bin/gpg
brew "pinentry-mac"            # setup/configure points gpg-agent at it

# --- Python (.zshrc, setup/python_install) ---
brew "poetry"
brew "pyenv"
brew "python@3.11"
brew "ruff"

# --- Java / Spark (.zshrc JAVA_HOME) ---
brew "openjdk"
brew "openjdk@11"
brew "openjdk@17"              # JAVA_HOME; required for PySpark 4.x
brew "apache-spark"

# --- Terraform / infra (.aliases, bin/tf_*) ---
brew "hashicorp/tap/terraform"
brew "hashicorp/tap/vault"
brew "terraform-docs"
brew "terragrunt"              # tg / tgf aliases
brew "awscli"
brew "databricks/tap/databricks"
brew "k9s"
brew "kubectx"

# --- Linting / tooling (.aliases) ---
brew "buf"
brew "pre-commit"              # pcr / pcra aliases
brew "protolint"
brew "shellcheck"
brew "yamllint"

# --- General CLI ---
brew "jq"
brew "tree"
brew "wget"

# --- Apps ---
cask "font-meslo-for-powerlevel10k"    # MesloLGS NF: starship prompt icons; used by iterm2/dotfiles.json
cask "iterm2"
cask "rancher"                 # .zshrc adds ~/.rd/bin
