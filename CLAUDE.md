# dotfiles

Personal shell, git and tool configuration for macOS (with partial Linux support).

## This is a personal, public repository

Everything committed here is visible to anyone on the internet. It must **never** contain:

- **Secrets:** API keys, tokens, passwords, private keys, credentials, or anything read from `~/.aws`, `~/.ssh`, vault, `.netrc`, etc.
- **Anything confidential about my employer:** internal hostnames, URLs or IPs, account or workspace IDs, internal repo, project or service names, SSO session names, vault roles, team or customer names, or details of internal infrastructure.

Employer-specific configuration lives in a separate private repo, loaded from the unmanaged `~/.zprofile`. Nothing in this repo names that repo or sources it, so this repo never needs its contents. Don't add a reference to it back into `.zshrc`. Secrets are kept only in the macOS Keychain and read at runtime. Never add a plain-text secrets file, an `export TOKEN=...` line, or a hard-coded value, not even a gitignored one.

Before committing, check the diff for anything above. When writing examples (docs, comments, test values), use generic placeholders like `my-repo` or `example.com`, never real internal names. If a change would need employer-specific detail to work, stop and ask rather than committing it.

## Protected files: `.zshrc` and `git/`

`.zshrc` and everything in `git/` are the most sensitive files here: a mistake breaks every new shell or every commit. `.claude/settings.json` denies Claude any edit to them, and to their symlinks `~/.zshrc`, `~/.gitconfig` and `~/.gitignore`.

To change one:

1. Write the complete proposed file to `scratch/`, named after the original with `.tmp` added (e.g. `scratch/.zshrc.tmp`, `scratch/git-config.tmp`). `scratch/` is gitignored.
2. Check it as far as possible without installing it, e.g. `zsh -n`, or load it in a throwaway shell (`ZDOTDIR=<tmp dir> zsh -i`), or `git config --file scratch/git-config.tmp --list`.
3. Summarise what changed and why. I review the file and copy it into place myself.

Never work around the deny rules, for example with shell redirection, `sed -i`, `cp` or `ln` onto these paths.

## Installing tools

Install everything with these, in order of preference:

1. **Homebrew:** add it to `Brewfile`, with its `tap` if needed. This is the default for every tool, including language runtimes like `bun`.
2. **apt:** only when there's no brew formula, or for Linux-only system packages. Goes in `setup/apt_install`.
3. **bun:** only for JS tools that aren't packaged for brew or apt (`bun add -g`).

Don't add `curl | bash` installers, `npm -g`, `pipx` or other one-off installers. If a tool can only be installed some other way, ask first.

The only exceptions:

- **Homebrew itself:** it has to be bootstrapped with its official `curl` installer.
- **Claude Code (`claude`):** uses Anthropic's native installer (into `~/.local/bin`), which keeps itself up to date.

## Layout

| Path | What it is |
| --- | --- |
| `.zshrc` | Shell config, symlinked to `~/.zshrc` |
| `.aliases` | Aliases, sourced by `.zshrc` straight from the repo (not symlinked) |
| `git/config`, `git/ignore` | Global git config and gitignore, symlinked to `~/.gitconfig` and `~/.gitignore` |
| `starship/starship.toml` | Prompt config, symlinked to `~/.config/starship.toml` |
| `bin/` | Small scripts; on `PATH` via `$DOTFILES_ROOT/bin`. Includes `code-status` (scheduled multi-repo report) and `code-session-summary` (its Claude Code hook) |
| `setup/` | One-time machine setup: `create_links` (symlinks), `brew_install`, `configure`, `iterm2`, `editors`, `claude`, `launchd`, plus python/apt installers |
| `claude/settings.json` | My personal Claude Code user settings, merged into `~/.claude/settings.json` by `setup/claude` |
| `launchd/` | launchd agent plists, installed by `setup/launchd` |
| `iterm2/dotfiles.json` | iTerm2 Dynamic Profile, installed by `setup/iterm2` |
| `editors/` | Desired settings for VS Code, Zed and PyCharm, checked and applied by `setup/editors` |
| `Brewfile` | Every Homebrew tap, formula and cask the repo depends on |
| `HOTKEYS.md` | Reference for the shell's key bindings and shortcuts |
| `README.md` | New-machine setup steps, including the manual ones |
| `.claude/settings.json` | Claude Code permissions: denies edits to `.zshrc` and `git/` |
| `scratch/` | Gitignored. Proposed versions of protected files for review |

## No diffs from normal use

Using my normal tools day to day must never change files in this repo. Every tracked file is either symlinked into `~` as a config the tool only *reads*, or only ever edited on purpose.

- **Don't track a file that a tool writes back to.** That includes settings files edited through an app's UI, caches, history and state. Track a read-only layer instead (e.g. the iTerm2 Dynamic Profile, never iTerm2's main preferences file).
- **If a tool owns a setting** (e.g. Claude Code's `/terminal-setup` writes an iTerm2 key mapping), let the tool manage it, and document running it as a manual step in `README.md` instead of copying its output into the repo.
- **Watch for tools that edit symlinked files.** Installers that append to `~/.zshrc` and `git config --global` (which writes into `git/config`) do this. Undo or relocate such edits rather than committing them, and prefer configuring the tool so it stops making them.
- **`~/.zprofile` is deliberately unmanaged.** It's where installers append their own lines (Homebrew's `brew shellenv`, JetBrains Toolbox, etc.), so those never touch the repo. It also loads the private employer config (see above). Nothing in `.zshrc` depends on it. Don't add it to the repo or symlink it.

## Keep these in sync

- **`HOTKEYS.md` ↔ `.zshrc`:** when you change a `bindkey`, `setopt`, plugin, or the fzf/zoxide setup, update `HOTKEYS.md` in the same commit. Write keys with Mac symbols (`⌃R`, `⌥B`, `⌘`), not `^R` or `M-b`: readers use Mac keyboards, or PC keyboards remapped to the Mac layout (Alt is ⌘). Keep `^X` only inside literal code such as `bindkey '^R'`.
- **`Brewfile` ↔ everything else:** when a file starts relying on a new Homebrew tool, add it to `Brewfile`, along with its `tap` if it needs one. Don't add install lists anywhere else; `setup/brew_install` just runs `brew bundle`.
- **`setup/create_links`:** when you add a new top-level dotfile, add its symlink here.
- **`iterm2/dotfiles.json`:** keep it minimal. Add a setting only when something in the repo depends on it (as `HOTKEYS.md` depends on Option sending Esc+), and record why in the README's iTerm2 table. Never copy settings across from an existing iTerm2 install. The `Guid` must match `PROFILE_GUID` in `setup/iterm2`.
- **`editors/`:** like the iTerm2 profile, keep it minimal. Add a setting only when something in the repo depends on it, and list it in the README's "Editor terminals" table. When adding an editor or terminal, also add a row to the "Terminals" table in `HOTKEYS.md`. Editors keep owning their settings files: never copy a whole editor settings file into the repo or symlink one. Change editors' files only through `setup/editors`, which touches just the keys in `editors/`.
- **`claude/settings.json`:** personal preferences only (model, plugins, my own hooks). Never permissions, sandbox, or other safety settings: those belong to whichever installer manages them, and `setup/claude` refuses to overwrite another installer's values. Change Claude's user settings only through this file and `setup/claude`, never by editing `~/.claude/settings.json`, and leave `--apply` to me. Hook commands must point at scripts in this repo (`$HOME/code/dotfiles/bin/...`).
- **`bin/code-status` and `launchd/`:** keep them employer-neutral. Anything org-specific (GitHub owner, app names) is read from `~/.config/code-status/env`, which lives outside this repo. Install or reload launchd agents only through `setup/launchd`, and leave running it to me.
- **`README.md` setup steps:** when a setup script is added or changes, or a new manual step appears, update the list.

## Notes

- `.zshrc` is live: `~/.zshrc` is a symlink to it, so edits take effect in the next shell. Check syntax with `zsh -n .zshrc`.
- Commits and tags are GPG-signed (`git/config`).
